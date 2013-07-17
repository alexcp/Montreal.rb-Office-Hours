require 'spec_helper'

describe Attending do

  let(:user1) { {"login"=>"alexcp","html_url"=>"","avatar_url"=>""} }
  let(:user2) { {"login"=>"test","html_url"=>"","avatar_url"=>""} }

  before :each do
    Event.stub current: "12-12-12"
  end

  it "should save new to a set" do
    Attending.add user1
  end

  it "should list user attending the current event" do
    Attending.add user2
    Attending.list.should have(2).items
  end

  it "should find user attendance by username" do
    Attending.exists?(user1["login"]).should be_true
  end

  it "should delete user from attending list" do
    Attending.cancel user1["login"]
    Attending.list.should have(1).items
  end
end
