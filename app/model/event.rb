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
    Redis.new.zscore :event, date
  end

  private

  def save
    Redis.new.zadd :event, id, date  unless exist?
  end

  def self.all
    Redis.new.zrange :event, 0, -1
  end

  def self.has_expired? date
    Time.parse(date).to_f < Time.now.to_f - ONE_DAY
  end

  def self.update date
    remove date
    GoogleCalendar.create_new_events if all.count <= 1
  end

  def self.remove date
    Redis.new.zrem :event, date
    Attending.delete_list_with date
  end
end
