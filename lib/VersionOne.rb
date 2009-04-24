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
end


