require 'redis'

class Attending
  def self.add user_info
    new user_info
  end
  
  def self.list
    redis = Redis.new
    redis.hgetall("Attending:#{Event.current}").values.map {|x|JSON.parse(x)}
  ensure
    redis.quit
  end

  def self.delete_list_with(date)
    redis = Redis.new
    redis.del "Attending:#{date}"
  ensure
    redis.quit
  end

  private

  def initialize user_info
    @username = user_info["login"]
    @avatar = user_info["avatar_url"]
    @url = user_info["html_url"]
    save
  end

  def save
    Redis.new.hset "Attending:#{Event.current}", @username, {username: @username, avatar: @avatar, url: @url}.to_json
  end
end
