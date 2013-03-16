require 'spec_helper'

describe GoogleCalendar do
  before :each do
    GoogleCalendar.stub search_for_future_calendar_events: "{\n \"items\": [\n  {\n   \"id\": \"148se7pvrf8a7uunj0ehc44nkk\",\n   \"start\": {\n    \"dateTime\": \"2013-03-20T09:00:00-04:00\"\n   }}\n ]\n}\n"
  end

  it "should retrieve the list of calendar events" do
    GoogleCalendar.get_next_calendar_events.should eq([{"id"=>"148se7pvrf8a7uunj0ehc44nkk", "start"=>{"dateTime"=>"2013-03-20T09:00:00-04:00"}}])
  end

  it "should create new event" do
    GoogleCalendar.create_new_events.first.should be_an_instance_of(Event)
  end
end
