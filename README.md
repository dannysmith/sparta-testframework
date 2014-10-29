# Moodle Automated UI Tests

NOTE: You can view this README as an HTML document by running `rake generate_docs` and visiting `./docs/index.html`.

This document describes the Moodle acceptance test/UI test framework. The framework has the following three goals, as agreed with the Sparta Test Manager:

1. Make it as easy as possible to write working tests quickly.
2. Reduce the amount of UI automation (clicking etc) as much as possible.
3. Provide a framework that allows non-rubyists (or people just starting out) to bug fix or add tests.

## Installation

**Prerequisites**: Ruby 1.9.3 and MySQL-devel. On OSX you could use [Homebrew](http://brew.sh) to install these. I'd reccomend [Rbenv](https://github.com/sstephenson/rbenv) is you're on OSX. On windows you should install Ruby200 (32-bit version) and DevKit.

On OSX/Unix, is should just be a case of checking out the repository and running `bundle install`. Unfortunately, on Windows things are a little more difficult.

### Cucumber Tests
There's only one build step, which executes the following commands:

````shell
# Set up rbenv in path
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
bundle install
bundle exec rbenv rehash
bundle exec ruby -v
echo "Running the rake task..."
CONFIG=ci HEADLESS=true bundle exec rake production
````

The build step should be set to execute with `stories` as the working directory and the artefact path should be set to `stories/results => results`.

### RSpec API Tests
There's only one build step, which executes the following commands:

````shell
# Set up rbenv in path
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
bundle install
bundle exec rbenv rehash
bundle exec ruby -v
echo "Running RSpec"
HEADLESS=true bundle exec rspec --format html --out ./results/koinos_report.html
````
The build step should be set to execute with `stories` as the working directory and the artefact path should be set to `stories/results/koinos_report.html => reports`.

## Strategy

The features and step_definitions are logically split into two types:

- **Clean Features** are acceptance criteria. They must always pass and are well-designed using page objects to abstract the workings of the individual pages.
- **Dirty Features** are quick and dirty features or scenarios written by QAs or developers to test a specific part of the system. It's not expected that they always pass, as they may depend on some complex configuration and may not be written using page objects.

By separating dirty features, it allows developers and QAs who are not experts at cucumber to use the tool without danger of breaking the acceptance tests running on TeamCity. If a dirty test is deemed important enough, it could be refactored and turned into clean acceptance criteria. If a dirty test fails, it could indicate that the test is broken, or that iRedeem is broken. If it transpires that a dirty test is broken, it can be tagged with @off so that it never runs, or simply deleted.

These dirty tests, while not run with every commit, could be run at the beginning of regression testing to indicate possible bugs for manual testers to investigate.

![Diagram](http://f.cl.ly/items/3P3g381H2U3C0c2C180E/Screen%20Shot%202014-02-25%20at%2012.19.11.png)

[This presentation](https://speakerdeck.com/dannysmith/clean-and-dirty-acceptance-tests-with-cucumber-and-watir) contains more detail on the idea.

## Basic constructs

This framework uses the PageObject gem as well as data models to represent the system.  Details of the methods available on data model classes are shown as comments in the model class definitions (`/features/support/models`). The methods available on page objects aren't documented as they should have self-explanatory names.

In general, the acceptance tests are high-level.

````ruby
When I do some things
Then something should be checked
````

In general, the actual actions to be taken are described in the step definitions:

````ruby
When /^I do some things$/ do
  visit(PageOnePage).set_something_up
  on(PageOnePage).do_another_thing
  visit(PageTwoPage).do_something_else
end

Then /^something should be checked$/ do
  on(PageTwoPage).assert_some_things_are_right
end
````

In general, data that is particular to the page, such as error messages that should be displayed, are kept within the page object. Data that is used accross scenario steps or lines is passed into the page object's methods.

In general, an object is passed first - usually a product:

````ruby
on(PageOnePage).do_another_thing(Product.last)
````

and, by convention, is referred to by a sensible name in the method. In the case of a product, this is always 'product', unless multiple products are passed.

````ruby
class PageOnePage
  def do_another_thing(product)
    @browser.h1(class: 'heading').should == prodct.data.name
  end
end
````

If other parameters are required by the method, they are passed as a hash of parameters. This convention borrows from Rails and helps make it clearer what is being passed in long lists of parameters:

````ruby
on(PageOnePage).do_another_thing(Product.last, quantity: 3, mode: 'list')
````

This hash of parameters is *always* referred to as `params` in the method. In the above example we can access the individual items with `params[:mode]`  or `params[:quantity]`.

````ruby
class PageOnePage
  def do_another_thing(product, params = {})
    if params[:mode] == 'list'
        @browser.h1(class: 'heading').should == prodct.data.name
        @product.text_field(class: 'qty').set(params[:quantity])
    end
  end
end
````

### Fat & Skinny Step Definitions

Taking a leaf out of Rails' book, step definitions should be kept as 'skinny' as possible, delegating work to either models or page objects.

## Writing Exploratory Tests

The fact that we've separated 'clean' acceptance crateria scenarios from quick-and-dirty other scenarios means that we can use cucumber for writing exploratory tests or bug tests. For example, given a bug:

![Bug](http://f.cl.ly/items/2Y3n1i3w1m163r0c2p3q/Screen%20Shot%202014-02-25%20at%2012.04.55.png)

We could write a quick and dirty feature:

![Dirty Feature](http://f.cl.ly/items/0l180N1b0q1e42460H3G/Screen%20Shot%202014-02-25%20at%2012.06.36.png)

Then write some quick and dirty step definitions that describe the bug:

![Dirty steps](http://f.cl.ly/items/2m3j1P0k3H0z2X220z0d/Screen%20Shot%202014-02-25%20at%2012.07.38.png)

If these pass as green, we know we've accurately described the bug:

````ruby
Then(/^an error should be displayed$/) do
  @browser.div(class: 'messages').text.should include 'Error'
end
````

We can then refactor this to 'reverse' the assertion to the test describes the expected behaviour:

````ruby
Then(/^an error should not be displayed$/) do
  @browser.div(class: 'messages').text.should_not include 'Error'
end
````

We can then commit this code and pass on to the developers for fixing. The developers could either use cucumber themselves to check that the bug is fixed, or when the ticket domes back into FT, we could run `rake t @jira-ird-787` to check that the fix has worked.

If it's decided that this test is worth adding to the clean features, we could refactor it to use page objects and retag it as @clean.

## Project Structure

````text
|- config.yml                           General configuration settings
|- cucumber.yml                         The cucumber profiles
|- Gemfile                              
|- Rakefile                             Rake tasks to execute tests
|- README.md                            This file
|- features/
|		|- clean/                       Clean features describing acceptance criteria
|		|- dirty/                       Quick and dirty features for testing
|		|- step_definitions/
|		|		|- clean-steps/         Step definitions for clean features
|		|		`- dirty_steps/         Step definitions for dirty features
|		`- support
|				|- data/                Setup and test data as YAML files
|				|- dirty_pages/         Page objects used in dirty tests
|				|- helpers/             Helper methods and overrides
|				|- models
|						|- basket.rb    A class for creating Basket objects (not very useful)
|						|- category.rb  A class for creating Category objects
|						|- koinos.rb    Helper classes for the Koinos API
|						|- mageapi.rb   Helper classes for the Magento API
|						|- member.rb    A class for creating Member objects
|						`- product.rb   A class for creating Product objects
|				|- pages                Properly-structured page objects
|				|- env.rb               Environment settings
|				`- hooks.rb             Global hooks and setup code
|- lib/
|		`- env_config.rb                A class to expose config.yml and YAML test data.
|- logs/                                API requests are logged here if the debug flag is on in config.yml
`- results/                             Contains rerun.txt and/or an HTML report.
| 	`- screenshots/                     Contains screenshots of failed scenarios
`- spec
    |- koinos_spec.rb                   Contains the Koinos RSpec tests
    |- koinos_test.rb                   A KoinosTest class for working with Koinos
    `- spec_helper.rb                   Setup and generic methods for use in koinos tests.
````


## Tagging Policy

This isn't set in stone, but as a guide, the following tags are recommended:

- **@dirty** - executed as part of the 'dirty' test suite. It's expected that some of these might fail.
- **@clean** - executed as part of the main test suite on CI Build Server. `rake production` currently executes all of these features, but when the test suite is large enough it would make sense to add a `rake regression` task to execute all @clean features, and attach this to a manual build on TeamCity. This could be run before deploying trunk to a new environment, and `rake production` could be set to run only @smoke features.
- **@not_started** - yet to be worked on, will never execute.
- **@wip** - being worked on, will never execute unless explicitly called with `rake t @wip`. It's safe to commit these to trunk knowing that they won't run.
- **@manual** - Flagged as a manual test, will never execute unless explicitly called with `rake t @manual`.
- **@headless** - A browser will not be opened for these features or scenarios.
- **@jira-ird-XXX** - Reference to a JIRA ticket. Ideally, all features should have this.
- **@slow** - The feature is particularly slow and should not be run regularly.
- **@smoke** - executed as part of the main test suite on CI Build Server **with every commit**. This isn't currently being used (see @clean, above).

Here's an example of one lifecycle that a feature might go through:

### 1. A BA creates a feature:

````ruby
@dirty @jira-ird-123 @not_started
Feature: Some Acceptance Criteria
	...
````

### 2. A Dev in Test decides that this feature should form part of the clean tests

After tidying up the feature and making use of any generic steps, the DiT might move it to /clean and retag it:

````ruby
@clean @jira-ird-123 @not_started
Feature: Some Acceptance Criteria
	...
````

### 3. A DiT starts work on it

````ruby
@clean @jira-ird-123 @wip
Feature: Some Acceptance Criteria
	...
````

Note: It's perfectly safe to commit @wip code to trunk, although in an ideal world this would't happen.

### 4. Work on the test is finished

````ruby
@clean @jira-ird-123
Feature: Some Acceptance Criteria
	...
````

### 5. Once of the scenarios is really slow, so we stop it running on every commit to trunk

````ruby
@clean @jira-ird-123 @wip
Feature: Some Acceptance Criteria
	This is a features

	Scenario: A quick scenario
		Given ...

	@slow
	Scenario: A slow scenario
		Given...
````

## Running Koinos Tests

The Koinos tests are written with RSpec, and use some of the libraries and classes that form part of the acceptance test suite, most noteably the Member class. A member is first created using UI automation on the Koinos web interface and then RSpec tests compare API returns against that.

The koinos tests make extensive use of KoinosTest class, found in `spec/koinos_test.rb`. This is intended to simplify future work on koinos tests. It's API is briefly documented in the file.

The koinos tests can be executed by running `rspec` in the `stories` directory. If you need to see the XML that's sent and recieved, set   `debug_api_requests: true` in `config.yml` and it will be output to STDOUT.

## Rake tasks

There are a number of rake tasks available, and you can always add more. Some to note in particular are:

- `rake generate_docs` converts the REAME.md file into an HTML document.
- `rake clean` clears out the logs and results directories. **You should run this before comitting** to avoid polluting the CI artifacts with old screenshots and reports.
- `rake production` used by TeamCity ro execute @clean features on CI.
- `rake wip` runs any features that are tagged @wip. You'll use this lots when working locally.
- `rake t @sometag` runs a specific tag, again you'll probably use this lots when working locally.
- `rake help` shows some details of the available tasks.

## Assumptions

The iRedeem test suite assumes that iRedeem has been configured in a sensible way. The actual configuration needed is far to complex to detail here, but in general:

- A vendor called 'Automation Test Vendor' exists with the right ID and settings.
- Pricebuilder is enabled and correctly configured.
- Global settings for exchange rates etc are set up correctly.
- Koinos is configured to allow connections from the correct IP ranges.
- uDropship is correctly configured.
- The Auction module is switched on and correctly configured.

## Using IRB inside the application

A test feature and scenario exists to allow you to access pry inside the applicaton. Run:

````
rake t @test
````

You'll then end up isnide a pry instance, with the test environment correctly loaded.

Needless to say, you can also start a pru instance by adding `binding.pry` anywhere in the code. This will start a pry instance at that point. [Pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) is also included, so ou have access to it's commands too.

## Commit Policy

In an ideal world:

1. Anyone can commit features to `/dirty`, but they must be tagged with a JIRA number and `@not_started`. The idea is that even BAs or developers could commit new feature files.
2. Any QAs or Devs can commit to `/dirty_steps` and `/dirty_pages`, but they must pass locally first.
3. Any code committed to `/clean`, whether features or ruby, must pass on CI and have been code reviewed by a another ruby developer.

## Contact

The majority of this framework was written by Danny Smith

- twitter: [@dannysmith](https://twitter.com/dannysmith)
- skype: [dannyasmith](skype:dannyasmith?chat)



