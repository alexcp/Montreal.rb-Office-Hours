require 'spec_helper'

describe Attending do
  before :each do
    Event.stub current: "12-12-12"
  end

  it "should save new to a set" do
    info = {"login"=>"alexcp","html_url"=>"","avatar_url"=>""} 
    Attending.add info
  end

  it "should list user attending the current event" do
    user2 = {"login"=>"test","html_url"=>"","avatar_url"=>""} 
    Attending.add user2
    JSON.parse(Attending.list).should have(2).items
  end
end
