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

   # self.site = "thecity2011@sina.com:123456@api.t.sina.com.cn/statuses/home_timeline.xml?source=1847941150"
   # self.site = "http://api.t.sina.com.cn/statuses"
   # self.element_name = "home_timeline"
   # self.user = "thecity2011@sina.com"
   # self.password = "123456"
   
   def self.all
     sina_url = "https://api.t.sina.com.cn/statuses/home_timeline.json?source=1847941150"
     # sina_url = "http://localhost:3000/home_timeline.json?source=1847941150"
     # result = open(sina_url,"Authorization"=>"Basic #{Base64.b64encode("thecity2011@sina.com:123456)}").read 
     # result = open(sina_url,:http_basic_authentication=>["thecity2011@sina.com:123456"]).read
     result = open(sina_url,:http_basic_authentication=>["thecity2011@sina.com", "123456"]).read
#      `curl -u thecity2011@sina.com:123456 -d "source=1847941150" http://api.t.sina.com.cn/statuses/home_timeline.xml`
#      `curl --user thecity2011@sina.com:123456 -d "source=1847941150" http://api.t.sina.com.cn/statuses/home_timeline.xml`
# `curl -d "source=1847941150&status=api test from curl" http://thecity2011@sina.com:123456@api.t.sina.com.cn/statuses/update.xml`     
     return JSON.parse(result)
   end
end


