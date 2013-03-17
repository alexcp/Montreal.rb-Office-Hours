require 'spec_helper'

describe Event do
  before :each do
    Redis.new.zremrangebyrank :event, 0, -1
    @event = Event.new "12-03-2013"
  end

  it "should save new event to redis" do
    @event.exist?.should be_true
  end

  it "should retrieve current event" do
    Time.stub now: Time.parse("12-02-2013")
    Event.current.should eq("12-03-2013")
  end

  it "should update current event when it has past" do
    event = Event.new "22-03-2013"
    Time.stub now: Time.parse("14-03-2013")
    Event.current.should eq("22-03-2013")
  end

  it "should check if one event has expired" do
    Time.stub now: Time.parse("14-03-2013")
    Event.has_expired?("12-03-2013").should be_true
  end
end
