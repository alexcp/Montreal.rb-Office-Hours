require 'redis'
require 'time'

class Event
  attr_reader :id, :date
  ONE_DAY = 86400

  def initialize date
    @id = Time.parse(date).to_f
    @date = date
    save
  end

  def self.current
    current = all.first
    update current if has_expired? current
    all.first  
  end

  def exist?
    redis = Redis.new 
    return redis.zscore :event, date
  ensure
    redis.quit
  end

  private

  def save
    redis = Redis.new
    redis.zadd :event, id, date  unless exist?
  ensure
    redis.quit
  end

  def self.all
    redis = Redis.new
    redis.zrange :event, 0, -1
  ensure
    redis.quit
  end

  def self.has_expired? date
    Time.parse(date).to_f < Time.now.to_f - ONE_DAY
  end

  def self.update date
    remove date
    Calendar.create_new_events if all.count <= 1
  end

  def self.remove date
    redis = Redis.new
    redis.zrem :event, date
    Attending.delete_list_with date
  ensure
    redis.quit
  end
end
