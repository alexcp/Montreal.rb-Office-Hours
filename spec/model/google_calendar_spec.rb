require 'spec_helper'

describe GoogleCalendar do
  it "should retrieve the list of next events" do
    GoogleCalendar.stub search_for_future_events: "{\n \"items\": [\n  {\n   \"id\": \"148se7pvrf8a7uunj0ehc44nkk\",\n   \"start\": {\n    \"dateTime\": \"2013-03-20T09:00:00-04:00\"\n   }}\n ]\n}\n"

    GoogleCalendar.get_next_events.should eq([{"id"=>"148se7pvrf8a7uunj0ehc44nkk", "start"=>{"dateTime"=>"2013-03-20T09:00:00-04:00"}}])
  end
end
