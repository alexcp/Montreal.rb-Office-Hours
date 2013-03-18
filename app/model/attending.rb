require 'redis'

class Attending
  def self.add user_info
    new user_info
  end
  
  def self.list
    Redis.new.hgetall("Attending:#{Event.current}").values
  end

  private

  def initialize user_info
    @username = user_info["login"]
    @avatar = user_info["avatar_url"]
    @url = user_info["html_url"]
    save
  end

  def save
    Redis.new.hset "Attending:#{Event.current}", @username, {username: @username, avatar: @avatar, url: @url}
  end

  def self.delete_list_with(date)
    Redis.new.del "Attending:#{date}"
  end
end
