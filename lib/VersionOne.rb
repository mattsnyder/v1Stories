require 'nokogiri'
require 'net/https'

class VersionOne
  def self.get_story(user,number)
    begin
      story = Nokogiri::XML(request_data(user,"/expectmore/rest-1.v1/Data/Story?where=Number='#{number.to_s}'"))
      collect_story_data(story.xpath('/Assets/Asset'))
    rescue
      {}
    end
  end
  
  def self.get_stories_by_iteration(user,project,iteration_name)
    stories = []
    iteration = Nokogiri::XML(request_data(user,"/expectmore/rest-1.v1/Data/Story?where=Scope.Name=%27#{CGI::escape(project)}%27;Timebox.Name=%27#{CGI::escape(iteration_name)}%27"))
    iteration.xpath('/Assets/Asset').each do |asset|
      stories.push(collect_story_data(asset))
    end
    stories
  end


  def self.authenticate_user(user)
      project = "Grange"
      message = Nokogiri::XML(request_data(user,"/expectmore/rest-1.v1"))
      message = collect_message_data(message.xpath('/Error'))
      return message.eql? "Unauthorized"
  end

  def self.get_project(user)
    begin
      projects = []
      project_data = Nokogiri::XML(request_data(user,"/expectmore/rest-1.v1/Data/Scope"))
      project_data.xpath('/Assets/Asset').each do |project|
        projects.push(collect_project_data(project))
      end
      projects
    rescue
      {}
    end
  end

    def self.get_iterations_for_project(user, project)
    begin
      iterations = []
      iteration_data = Nokogiri::XML(request_data(user,"/expectmore/rest-1.v1/Data/Timebox?sel=Name&where=Schedule.Name=%27#{CGI::escape(project)}%27"))
      iteration_data.xpath('/Assets/Asset').each do |iteration|
        iterations.push(collect_iteration_data(iteration))
      end
      iterations
    rescue
      {}
    end
  end
  
  private
  WEBSITE_ROOT = "www10.v1host.com"
  
  def self.request_data(user,target)
    story_data = ""
    http = Net::HTTP.new(WEBSITE_ROOT, 443)
    http.use_ssl = true
    http.start do |http|
      req = Net::HTTP::Get.new(target)
      req.basic_auth(user.username, user.password)
      response = http.request(req)
      story_data = response.body
    end
    story_data
  end
 

  def self.collect_story_data(asset)
    story = Story.new
    story.title = asset.xpath('Attribute[@name="Name"]').text.to_s.strip_tags
    story.owner = asset.xpath('Attribute[@name="Owners.Name"]/Value').text.to_s.strip_tags
    story.estimate = asset.xpath('Attribute[@name="Estimate"]').text.to_s.strip_tags
    story.description = asset.xpath('Attribute[@name="Description"]').text.to_s.strip_tags
    story.project = asset.xpath('Attribute[@name="Scope.Name"]').text.to_s.strip_tags
    story.theme = asset.xpath('Attribute[@name="Parent.Name"]').text.to_s.strip_tags
    story.iteration = asset.xpath('Attribute[@name="Timebox.Name"]').text.to_s.strip_tags
    story.number = asset.xpath('Attribute[@name="Number"]').text.to_s.strip_tags
    story
  end

  def self.collect_message_data(asset)
    asset.xpath('.//Message').text.to_s.strip_tags
  end

  def self.collect_project_data(asset)
    project = Project.new
    project.name = asset.xpath('Attribute[@name="Name"]').text.to_s.strip_tags
    project.schedule = asset.xpath('Attribute[@name="Schedule.Name"]').text.to_s.strip_tags
    project

  end

  def self.collect_iteration_data(asset)
   iteration = Iteration.new 
   iteration.name = asset.xpath('Attribute[@name="Name"]').text.to_s.strip_tags
   iteration
  end

end


