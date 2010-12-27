# 3,8,13,18,23,28,33,38,43,48,53,58 * * * * cd /home/eywww/NewYouth/current/ && /home/eywww/NewYouth/current/script/runner -e production "Status.get_status"


class Status < ActiveRecord::Base
  

  def self.get_status    
    latest_status = Status.last
    
    statuses = RemoteStatus.all
    
    statuses.reverse_each do |status|
      if latest_status == nil || (status["created_at"] > latest_status.remote_created_at.to_s)
        Status.create(
          :remote_id         => status["id"],
          :remote_created_at => status["created_at"],
          :screen_name       => status["user"]["screen_name"],
          :name              => status["user"]["name"],
          :text              => status["text"]
        )
      end
    end

  end
  
  
end
