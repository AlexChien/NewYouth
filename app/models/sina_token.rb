# Use a gem to do the heavy stuff
# require 'myservice'

class SinaToken < ConsumerToken
  SINA_SERVICE_SETTINGS={:site=>"http://api.t.sina.com.cn"}
  
  # override self.consumer so we don't have to specify url's in options
  def self.consumer
    @consumer ||= OAuth::Consumer.new(credentials[:key], credentials[:secret], SINA_SERVICE_SETTINGS)
  end
  
  # overide client to return a high level client object
  def client
    # @client ||= MyService::Client.new(SinaToken.consumer.key, SinaToken.consumer.secret, token, secret)
  end
  
  # optionally add various often used methods here
  def shout(message)
    client.shout(message)
  end
end