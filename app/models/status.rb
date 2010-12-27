class Status < ActiveRecord::Base
  

  def self.get_status
    "stainless:asd123abc@api.t.sina.com.cn/statuses/home_timeline.xml?source=1847941150"    
  end
  
end
