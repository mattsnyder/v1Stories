require 'nokogiri'
require 'net/https'

class VersionOne
  def self.get_story(number)
    begin
      story = Nokogiri::XML(request_data("/expectmore/rest-1.v1/Data/Story/" + number.to_s))
      collect_story_data(story.xpath('/Asset'))
    rescue
      {}
    end
  end
  
  def self.get_stories_by_iteration(iteration_name)
    stories = []
    iteration = Nokogiri::XML(request_data("/expectmore/rest-1.v1/Data/Story?where=Timebox.Name=%27#{CGI::escape(iteration_name)}%27"))
    iteration.xpath('/Assets/Asset').each do |asset|
      stories.push(collect_story_data(asset))
    end
    {:stories => stories}
  end
  
  private
  WEBSITE_ROOT = "www10.v1host.com"
  V1_USER_NAME = "developer"
  V1_PASSWORD = "developer"
  
  def self.request_data(target)
    story_data = ""
    http = Net::HTTP.new(WEBSITE_ROOT, 443)
    http.use_ssl = true
    http.start do |http|
      req = Net::HTTP::Get.new(target)
      req.basic_auth(V1_USER_NAME, V1_PASSWORD)
      response = http.request(req)
      story_data = response.body
    end
    story_data
  end
  
  def self.collect_story_data(asset)
    {  :title => asset.xpath('Attribute[@name="Name"]').text,
       :owner => asset.xpath('Attribute[@name="Owners.Name"]/Value').text,
       :estimate => asset.xpath('Attribute[@name="Estimate"]').text,
       :description => asset.xpath('Attribute[@name="Description"]').text,
       :theme => asset.xpath('Attribute[@name="Scope.Name"]').text,
       :iteration => asset.xpath('Attribute[@name="Timebox.Name"]').text,
       :number => asset.xpath('@id').text.match('[0-9]+').to_s
      }
  end
end


