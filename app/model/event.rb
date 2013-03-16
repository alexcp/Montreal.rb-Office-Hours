class Event
  attr_reader :uid, :date

  def initialize uid, date
    @uid = uid 
    @date = date
  end
end
