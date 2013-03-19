require 'spec_helper'

describe Attending do
  it "should save new to a set" do
    info = {"login"=>"alexcp","html_url"=>"","avatar_url"=>""} 
    Attending.add info
  end

  it "should list user attending the current event" do
    user2 = {"login"=>"test","html_url"=>"","avatar_url"=>""} 
    Attending.add user2
    Attending.list.should have(2).items
  end
end
