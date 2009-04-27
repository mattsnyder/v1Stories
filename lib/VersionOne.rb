require 'nokogiri'
require 'net/https'

class VersionOne
  def self.get_story(number)
  story_data = ""
  http = Net::HTTP.new("www10.v1host.com", 443)
  http.use_ssl = true
  http.start do |http|
    req = Net::HTTP::Get.new("/expectmore/rest-1.v1/Data/Story/" + number.to_s)
    req.basic_auth("developer", "developer")
    response = http.request(req)
    story_data = response.body
  end  
  
  doc = Nokogiri::XML(story_data)    
  
  begin
   { :title => doc.xpath('/Asset/Attribute[@name="Name"]').text,
     :owner => doc.xpath('/Asset/Attribute[@name="Owners.Name"]/Value').text,
     :estimate => doc.xpath('/Asset/Attribute[@name="Estimate"]').text,
     :description => doc.xpath('/Asset/Attribute[@name="Description"]').text,
     :theme => doc.xpath('/Asset/Attribute[@name="Scope.Name"]').text,
     :iteration => doc.xpath('/Asset/Attribute[@name="Timebox.Name"]').text,
     :number => number.to_s
    }
  rescue
    {}
  end
  
  end
  
  def self.get_stories_by_iteration(iteration_name)
    story_data = ""
    http = Net::HTTP.new("www10.v1host.com", 443)
    http.use_ssl = true
    http.start do |http|
      req = Net::HTTP::Get.new("/expectmore/rest-1.v1/Data/Story?where=Timebox.Name=%27Iteration%2012%27")
      req.basic_auth("developer", "developer")
      response = http.request(req)
      story_data = response.body
    end  

    doc = Nokogiri::XML(story_data)
    iteration = {:stories => []}
    doc.xpath('/Assets/Asset').each do |asset|
      iteration[:stories].push(
      {  :title => asset.xpath('Attribute[@name="Name"]').text,
         :owner => asset.xpath('Attribute[@name="Owners.Name"]/Value').text,
         :estimate => asset.xpath('Attribute[@name="Estimate"]').text,
         :description => asset.xpath('Attribute[@name="Description"]').text,
         :theme => asset.xpath('Attribute[@name="Scope.Name"]').text,
         :iteration => asset.xpath('Attribute[@name="Timebox.Name"]').text,
         :number => asset.xpath('@id').text.match('[0-9]+').to_s
        })
    end
    iteration
  end
  
  private
  def new_story_data(title, description=nil, theme=nil, owner=nil, estimate=nil, iteration=nil)
    {:number=>rand(100),:title => title, :description => description, :theme => theme, :owner => owner, :estimate => estimate, :iteration => iteration}
  end
end


