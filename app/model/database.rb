require 'redis'

class Database
  def self.method_missing meth, *args
    redis = Redis.new 
    return redis.send meth, *args
  ensure
    redis.quit
  end
end
