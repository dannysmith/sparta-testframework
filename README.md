# Moodle Automated UI Tests

[ ![Codeship Status for spartaglobal/sparta-testframework](https://www.codeship.io/projects/af822680-4348-0132-1673-4ed6388ce112/status)](https://www.codeship.io/projects/44637)

NOTE: You can view this README as an HTML document by running `rake generate_docs` and visiting `./docs/index.html`.

This document describes the Moodle acceptance test/UI test framework. The framework has the following three goals, as agreed with the Sparta Test Manager:

1. Make it as easy as possible to write working tests quickly.
2. Reduce the amount of UI automation (clicking etc) as much as possible.
3. Provide a framework that allows non-rubyists (or people just starting out) to bug fix or add tests.

## Installation

**Prerequisites**: Ruby 1.9.3 and MySQL-devel. On OSX you could use [Homebrew](http://brew.sh) to install these. I'd reccomend [Rbenv](https://github.com/sstephenson/rbenv) is you're on OSX. 

On windows you should install Ruby193 (32-bit version) and DevKit.

On OSX/Unix/windows, is should just be a case of checking out the repository and running `bundle install`.

### Cucumber Tests
There's only one build step, which executes the following commands:

````shell
# Set up rbenv in path
rvm use $(cat .ruby-version) --install
bundle install
bundle exec ruby -v
echo "Running the rake task..."
CONFIG=ci HEADLESS=true bundle exec rake production
````

### Test Setup
The registration automation is dependant on the test user not already existing in the database and the test email being empty. 
If you are using gmail for the test email then there are instructions in the wiki on how to setup automated email deletion.
[Test Setup Page](https://github.com/spartaglobal/sparta-testframework/wiki/Test-Setup)

## Strategy

The features and step_definitions are logically split into two types:

- **Clean Features** are acceptance criteria. They must always pass and are well-designed using page objects to abstract the workings of the individual pages. The tech lead/reviewer has final on what goes in here. They will review the dirty code, make changes and add them here.
- **Dirty Features** are quick and dirty features or scenarios written by QAs or developers to test a specific part of the system. It's not expected that they always pass, as they may depend on some complex configuration and may not be written using page objects. This is default where the devlopers will make their code. 

By separating dirty features, it allows developers and QAs who are not experts at cucumber to use the tool without danger of breaking the acceptance tests running on Codeship. If a dirty test is deemed important enough, it could be refactored and turned into clean acceptance criteria and added by the tech reviewer. If a dirty test fails, it could indicate that the test is broken, or that iRedeem is broken. If it transpires that a dirty test is broken, it can be tagged with @off so that it never runs, or simply deleted.

These dirty tests, while not run with every commit, could be run at the beginning of regression testing to indicate possible bugs for manual testers to investigate.

## Basic constructs

### Features

In general, the acceptance tests are high-level.

````ruby
When I do some things
Then something should be checked
````

### Page Objects & the App class

The app class is where you call and initalise the page ogjects for each test that they are needed. When a new page object is added, you will need to add the "insert_name_page" class to here

```
class App
  def initialize(b)
    @browser = b
  end
 
  def home
    HomePage.new @browser
  end
  
  def dashboard
    Dashboard.new @browser
  end
  
  def example
    InsertName.new @browser
  end
  ...
end
```

Page Objects are where you write the code required to run the tests. The methods within the page objects contain the logic code to actually carry out the tests

```
class Dashboard < GenericPage
  def site_admin
    @browser.text.include?("Site Admin")
  end
  
  def admin_panel
    @browser.p(:id, "expandable_branch_71_siteadministration").text
  end
  ...
end
```

Once made and checked to be working fine, then you should be able to call the actions within the step_definitions to execute the code

### Step Definitions

In general, the actual actions to be taken are described in the step definitions:

````ruby
When /^I do some things$/ do
  @app.home.set_something_up
  @app.home.do_another_thing
  @app.courses.do_something_else
end

Then /^something should be checked$/ do
  @app.courses.assert_some_things_are_right
end
````

In general, data that is particular to the page, such as error messages that should be displayed, are kept within the page object. Data that is used accross scenario steps or lines is passed into the page object's methods.

In general, an object is passed first:

````ruby
@app.courses.do_another_thing(Course.first)
````

and, by convention, is referred to by a sensible name in the method. In the case of a course, this is always 'course', unless multiple courses are passed.

````ruby
class PageOnePage
  def do_another_thing(course)
    @browser.h1(class: 'heading').should == course.data.name
  end
end
````

If other parameters are required by the method, they are passed as a hash of parameters. This convention borrows from Rails and helps make it clearer what is being passed in long lists of parameters:

````ruby
on(PageOnePage).do_another_thing(Course.last, candidates: 3, mode: 'list')
````

This hash of parameters is *always* referred to as `params` in the method. In the above example we can access the individual items with `params[:mode]`  or `params[:candidates]`.

````ruby
class PageOnePage
  def do_another_thing(course, params = {})
    if params[:mode] == 'list'
        @browser.h1(class: 'heading').should == course.data.name
        @course.text_field(class: 'qty').set(params[:candidates])
    end
  end
end
````

### Fat & Skinny Step Definitions

Taking a leaf out of Rails' book, step definitions should be kept as 'skinny' as possible, delegating work to either models or page objects.


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
|		`- support
|				|- data/                Setup and test data as YAML files
|				|- helpers/             Helper methods and overrides
|				|- models
|						`- category.rb        A class for creating Category objects
|				|- pages                Properly-structured page objects
|				|- env.rb               Environment settings
|				`- hooks.rb             Global hooks and setup code
|- lib/
|		`- env_config.rb                A class to expose config.yml and YAML test data.
|- logs/                                API requests are logged here if the debug flag is on in config.yml
`- results/                             Contains rerun.txt and/or an HTML report.
| 	`- screenshots/                     Contains screenshots of failed scenarios
`- spec
````


## Tagging Policy

This isn't set in stone, but as a guide, the following tags are recommended:

Currently being used: 

- **@clean** - executed as part of the main test suite on CI Build Server. `rake production` currently executes all of these features, but when the test suite is large enough it would make sense to add a `rake regression` task to execute all @clean features, and attach this to a manual build on Codeship. This could be run before deploying trunk to a new environment, and `rake production` could be set to run only @smoke features.
- **@wip** - being worked on, will never execute unless explicitly called with `rake t @wip`. It's safe to commit these to master knowing that they won't run.
- **@MDL-XXX** - Reference to a JIRA story or task. Ideally, all features should have this.


These are available to be used :

- **@dirty** - executed as part of the 'dirty' test suite. It's expected that some of these might fail.
- **@not_started** - yet to be worked on, will never execute.
- **@manual** - Flagged as a manual test, will never execute unless explicitly called with `rake t @manual`.
- **@headless** - A browser will not be opened for these features or scenarios.
- **@slow** - The feature is particularly slow and should not be run regularly.
- **@smoke** - executed as part of the main test suite on CI Build Server **with every push**. This isn't currently being used (see @clean, above).


## Lifecycle

Here's an example of one lifecycle that a feature might go through:

For more in-depth project workflow, check out our wiki page: [Workflow](https://github.com/spartaglobal/sparta-testframework/wiki/Project-Workflow)

### 1. A BA creates a feature:

````ruby
@dirty @MDL-123 @not_started
Feature: Some Acceptance Criteria
	...
````

It may be that the Behave Pro plugin is used so BAs can create features directly in JIRA.

### 2. A Dev in Test decides that this feature should form part of the clean tests

After tidying up the feature and making use of any generic steps, the DiT might move it to /clean and retag it:

````ruby
@clean @MDL-123 @not_started
Feature: Some Acceptance Criteria
	...
````

### 3. A DiT starts work on it

````ruby
@clean @MDL-123 @wip
Feature: Some Acceptance Criteria
	...
````

Note: It's perfectly safe to commit @wip code to trunk, although in an ideal world this would't happen.

### 4. Work on the test is finished

````ruby
@clean @MDL-123
Feature: Some Acceptance Criteria
	...
````

### 5. Once of the scenarios is really slow, so we stop it running on every commit to master

````ruby
@clean @MDL-123 @wip
Feature: Some Acceptance Criteria
	This is a features

	Scenario: A quick scenario
		Given ...

	@slow
	Scenario: A slow scenario
		Given...
````

## Rake tasks

There are a number of rake tasks available, and you can always add more. Some to note in particular are:

- `rake generate_docs` converts the REAME.md file into an HTML document.
- `rake clean` clears out the logs and results directories. **You should run this before comitting** to avoid polluting the CI artifacts with old screenshots and reports.
- `rake production` used by Codeship ro execute @clean features on CI.
- `rake wip` runs any features that are tagged @wip. You'll use this lots when working locally.
- `rake t @sometag` runs a specific tag, again you'll probably use this lots when working locally.
- `rake help` shows some details of the available tasks.


## Using IRB inside the application

A test feature and scenario exists to allow you to access pry inside the applicaton. Run:

````
rake t @test
````

You'll then end up isnide a pry instance, with the test environment correctly loaded.

Needless to say, you can also start a pru instance by adding `binding.pry` anywhere in the code. This will start a pry instance at that point. [Pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) is also included, so ou have access to it's commands too.

## Working on a new feature of the test suite

First, create a feature branch:

````shell
master$> git checkout -b my-feature
````

Then fire up the app and do some work:

````shell
my-feature$> subl .
````

Regularly test, commit and push that work to github:

````shell
my-feature$> rspec
my-feature$> git commit -m "Some Stuff"
my-feature$> git push
````

Then submit a pull request to the master branch (note that you'll need the hub gem installed for this to work):

````shell
my-feature$> git pull-request -b master
````

Head to GitHub to accept the pull request and merge to `master`.

## Deploying to Production

To deploy `master` to production:

````shell
master$> git pull
master$> git checkout production
production$> git pull
production$> git merge master
production$> git push
master$> git checkout master
````


## Commit Policy

In an ideal world:

1. Anyone can commit features to `/dirty`, but they must be tagged with a JIRA number and `@not_started`. The idea is that even BAs or developers could commit new feature files.
2. Any QAs or Devs can commit to `/dirty_steps` and `/dirty_pages`, but they must pass locally first.
3. Any code committed to `/clean`, whether features or ruby, must pass on CI and have been code reviewed by the tech lead or appointed ruby developer.

## Contributors

Here is a list of everyone that has worked on the testframework. If there are any issues that need to be brought to our attention, please contact us below with "Your Name | sparta-testframework | Problem" in the email subject field.

| Username | Name | E-mail |
| -------|----------|----------|
| aMuir | Aaron Muir | amuir@testingcircle.com |
| dannysmith | Danny Smith | dmsith@testingcircle.com |
| dkentuk | David Kent | dkent@testingcircle.com |
| JaneLast | Jane Last | jlast@testingcircle.com |
| romeoledesma | Romeo Ledesma | rledesma@testingcircle.com |
| TGohil | Trishul Gohil | tgohil@testingcircle.com |



