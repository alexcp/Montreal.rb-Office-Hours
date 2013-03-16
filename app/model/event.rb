require 'redis'

class Event
  attr_reader :uid, :date

  def initialize uid, date
    @uid = uid 
    @date = date
    save
  end

  def save
    unless get uid
      Redis.new.hset("events", uid, date)
    end
  end

  def self.get uid
    Redis.new.hget 'events', uid 
  end
end
