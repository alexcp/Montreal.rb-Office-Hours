require 'spec_helper'

describe Event do
  it "should save new event to redis" do
    event = Event.new "123", "12-03-2013"
    Event.get("123").should eq("12-03-2013")
  end
end
