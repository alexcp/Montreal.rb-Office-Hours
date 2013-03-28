require 'net/http'
require 'json'

class Calendar

  def self.create_new_events
    get_next_calendar_events.map { |calendar_event| Event.new calendar_event["start"]["dateTime"] }
  end

  private

  def self.get_next_calendar_events
    next_events = JSON.parse search_for_future_calendar_events
    next_events["items"]
  end

  def self.search_for_future_calendar_events
    uri = URI.parse("https://www.googleapis.com/calendar/v3/calendars/j2tp04gen46s0e097fsgcs2s4k%40group.calendar.google.com/events?orderBy=startTime&singleEvents=true&q=Montreal.rb+Office+Hours&timeMin=#{Time.now.strftime("%FT%T%:z")}&fields=items(id%2Cstart)&key=#{ENV['GOOGLE_API_KEY']}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request).body
  end
end
