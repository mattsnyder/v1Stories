# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

def new_story_data(title, description=nil, theme=nil, owner=nil, estimate=nil, iteration=nil, number=nil)
  number = rand(100) if(number.nil?)
  {:number=>number,:title => title, :description => description, :theme => theme, :owner => owner, :estimate => estimate, :iteration => iteration}
end

def new_story(title, description=nil, theme=nil, owner=nil)
  data = new_story_data(title, description=nil, theme=nil, owner=nil)
  data.inject(Story.new) {|story,data|
      attribute, value = data
      story.send(attribute.to_s + "=", value)
      story
    }
end

def new_story_instance(title, description=nil, theme=nil, owner=nil, estimate=nil, iteration=nil, number=nil)
  story = Story.new
  story.title =title
  story.description=description
  story.theme=theme
  story.owner=owner
  story.estimate=estimate
  story.iteration=iteration
  story.number=number
  story

end
def new_project(name, schedule)
  project = Project.new
  project.name=name
  project.schedule=schedule
  project
end

def new_asset_xml(story_data)
   <<-xml 
   <Asset id="Story:#{rand(1000)}">
    <Attribute name="Owners.Name">
 	    <Value>#{story_data.owner}</Value>
 	  </Attribute>
 	  <Attribute name="Estimate">#{story_data.estimate}</Attribute>
 	  <Attribute name="Description">#{story_data.description}</Attribute>
    <Attribute name="Name">#{story_data.title}</Attribute>
    <Attribute name="Scope.Name">#{story_data.theme}</Attribute>
    <Attribute name="Timebox.Name">#{story_data.iteration}</Attribute>
    <Attribute name="Number">#{story_data.number}</Attribute>
   </Asset>
   xml
end


Spec::Matchers.define(:have_a_story_with_title) do |expected_title|
  match do |story_list|
    story_list.any? {|story| story.title == expected_title}
  end

  failure_message_for_should do |story_list|
    msg = "expected to find a story with title #{expected_title}, but story list contained "
    story_titles = story_list.map(&:title)
    msg + story_titles.join(", ")
  end

end

Spec::Matchers.define(:have_a_project_with_name_and_schedule) do |expected_name,expected_schedule|
  match do |project_list|
    project_list.any? {|project| project.name == expected_name; project.schedule == expected_schedule}
  end

  failure_message_for_should do |project_list|
    msg = "expected to find a project with name #{expected_name} and schedule #{expected_schedule}, but project list contained "
    project_names = project_list.map(&:name) 
    msg + project_names.join(", ")
  end

end

Spec::Matchers.define(:contain_the_user) do |expected_username,expected_password|
  match do |session|
      session != nil
  end
  failure_message_for_should do |session|
    msg = "expected to find a user with name #{expected_username} and password #{expected_password}, but session did not contain the user"
  end

end

Spec::Matchers.define(:end_with) do |expected_string_ending|
  match do |string|
    string.length.should > expected_string_ending.length
    string.slice(-1*expected_string_ending.length, expected_string_ending.length) == expected_string_ending
  end

  failure_message_for_should do |string|
    msg = "expected to string to end with '#{expected_string_ending}', but string ended with "
    msg << "'#{string.slice(-1*expected_string_ending.length, expected_string_ending.length)}'"
  end

end


