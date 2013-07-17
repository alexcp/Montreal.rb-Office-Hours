class Attending
  def self.add user_info
    new user_info
  end

  def self.delete_user_with(username)
    Database.hdel "Attending:#{Event.current}", username
  end
  
  def self.list
    Database.hgetall("Attending:#{Event.current}").values.map {|x|JSON.parse(x)}
  end

  def self.delete_list_with(date)
    Database.del "Attending:#{date}"
  end

  private

  def initialize user_info
    @username = user_info["login"]
    @avatar = user_info["avatar_url"]
    @url = user_info["html_url"]
    save
  end

  def save
    Database.hset "Attending:#{Event.current}", @username, {username: @username, avatar: @avatar, url: @url}.to_json
  end
end
