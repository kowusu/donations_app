require 'spec_helper'

describe User do
  context "email and password are assigned" do
    let(:user) { User.new :email => "user@email.com", :password => 'password' }
    it "should be able to save" do
      user.save.should == true
    end
    it "should be valid" do
      user.should be_valid
    end
  end
  
  context "email and password are unassigned" do
    let(:user) { User.new }
    it "should not be able to save" do
      user.save.should_not == true
    end
    it "should not be valid" do
      user.should_not be_valid
    end
  end
end
