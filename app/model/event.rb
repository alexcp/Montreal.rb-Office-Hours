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

  def save
    Redis.new.zadd(:event, id, date ) unless exist?
  end

  def exist?
    Redis.new.zscore :event, date
  end

  def self.current
    current = all.first
    remove(current) if has_expired?(current)
    all.first
  end

  def self.all
    Redis.new.zrange(:event, 0, -1)
  end

  def self.remove(date)
    Redis.new.zrem :event, date
  end

  def self.has_expired?(date)
    Time.parse(date).to_f < Time.now.to_f - ONE_DAY
  end
end
