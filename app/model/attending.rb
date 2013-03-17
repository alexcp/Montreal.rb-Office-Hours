require 'redis'

class Attending
  def initialize github_user_info
    @username = github_user_info["login"]
    @avatar = github_user_info["avatar_url"]
    @url = github_user_info["html_url"]
    save
  end

  def save
    Redis.new.hset "Attending:#{Event.current}", @username, {username: @username, avatar: @avatar, url: @url}
  end
  
  def self.list
    Redis.new.hgetall("Attending:#{Event.current}").values
  end

  def self.delete_list_with(date)
    Redis.new.del "Attending:#{date}"
  end
end
