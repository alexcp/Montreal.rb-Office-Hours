require 'time'
require 'active_support/core_ext/numeric/time'

class Event
  attr_reader :id, :date

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
    Database.zscore :event, date
  end

  private

  def save
    Database.zadd :event, id, date  unless exist?
  end

  def self.all
    Database.zrange :event, 0, -1
  end

  def self.has_expired? date
    # The event will expires 2 hours after is date
    Time.parse(date).to_f < Time.now.to_f - 2.hours.to_i
  rescue TypeError
    true
  end

  def self.update date
    remove date
    Calendar.create_new_events if all.count <= 1
  end

  def self.remove date
    Database.zrem :event, date
    Attending.delete_list_with date
  end
end
