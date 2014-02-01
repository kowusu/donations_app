require 'spec_helper'

describe Donation do
  
  describe "#fields" do
    it { should respond_to(:title) }
    it { should respond_to(:description) }
    it { should respond_to(:donatable) }
  end
  
  describe "#validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end
  
  describe "#associations" do
    it { should belong_to(:donatable) }
  end
  
  context "title and description are assigned" do
    let(:donation) { Donation.new :title => "Donation Test Title", :description => "This is test description for the donation" }
    it "should be able to save" do
      donation.save.should == true
    end
    it "should be valid" do
      donation.should be_valid
    end
  end
  
  context "title is assigned and description is unassigned" do
    let(:donation) { Donation.new :title => "Donation Test Title" }
    it "should not be able to save" do
      donation.save.should_not == true
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "description is assigned and title is unassigned" do
    let(:donation) { Donation.new :description => "This is test description for the donation" }
    it "should not be able to save" do
      donation.save.should_not == true 
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
    
  end
  
  context "title and description are unassigned" do
    let(:donation) { Donation.new  }
    it "should not be able to save" do
      donation.save.should_not == true 
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
end
