require 'open-uri'
require 'json'
require 'base64'

# require 'nokogiri'
# require 'mechanize'
# 
# WWW::Mechanize.html_parser = Nokogiri::XML
# 
# agent = WWW::Mechanize.new
# agent.get('/home_timeline.xml').links.each do |link|
#   p link
# end

class RemoteStatus

   # self.site = "stainless:asd123abc@api.t.sina.com.cn/statuses/home_timeline.xml?source=1847941150"
   # self.site = "http://api.t.sina.com.cn/statuses"
   # self.element_name = "home_timeline"
   # self.user = "stainless"
   # self.password = "asd123abc"
   
   def self.all
     # sina_url = "https://api.t.sina.com.cn/statuses/home_timeline.xml?source=1847941150"
     sina_url = "http://localhost:3000/home_timeline.json?source=1847941150"
     # result = open(sina_url,"Authorization"=>"Basic #{Base64.b64encode("stainless:asd123abc")}").read 
     # result = open(sina_url,:http_basic_authentication=>["stainless", "asd123abc"]).read
     result = open(sina_url,:http_basic_authentication=>["stainless", "asd123abc"]).read
#      `curl -u stainless:asd123abc -d "source=1847941150" http://api.t.sina.com.cn/statuses/home_timeline.xml`
#      `curl --user stainless:asd123abc -d "source=1847941150" http://api.t.sina.com.cn/statuses/home_timeline.xml`
# `curl -d "source=1847941150&status=api test from curl" http://stainless:asd123abc@api.t.sina.com.cn/statuses/update.xml`     
     return JSON.parse(result)
   end
end


