require 'spec_helper'

describe Experience do
  
  describe "#fields" do
    it { should respond_to(:primary_contact_name) }
    it { should respond_to(:location) }
    it { should respond_to(:latitude) }
    it { should respond_to(:longitude) }
  end
  
  describe "#validations" do
    it { should validate_presence_of(:primary_contact_name) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
  
  describe "#associations" do
    it { should have_one(:donation) }
  end
  
  context "primary_contact_name, latitude, longitude are assigned" do
    let(:exp) { Experience.new :primary_contact_name => "Contact Name", :latitude => 2.0, :longitude => 3.0 }
    it "should be able to save" do
      exp.save.should == true
    end
    it "should be valid" do
      exp.should be_valid
    end
  end
  
  context "primary_contact_name is assigned, latitude and longitude are unassigned" do
    let(:exp) { Experience.new :primary_contact_name => "Contact Name" }
    it "should be able to save" do
      exp.save.should_not == true
    end
    it "should be valid" do
      exp.should_not be_valid
    end
  end
  
  context "primary_contact_name and latitude is assigned, and longitude are unassigned" do
    let(:exp) { Experience.new :primary_contact_name => "Contact Name", :latitude => 2.0 }
    it "should be able to save" do
      exp.save.should_not == true
    end
    it "should be valid" do
      exp.should_not be_valid
    end
  end
  
  context "longitude and latitude is assigned, and primary_contact_name are unassigned" do
    let(:exp) { Experience.new :longitude => 3.0  }
    it "should be able to save" do
      exp.save.should_not == true
    end
    it "should be valid" do
      exp.should_not be_valid
    end
  end
  
  context "longitude is assigned, latitude and primary_contact_name are unassigned" do
    let(:exp) { Experience.new :longitude => 3.0 }
    it "should be able to save" do
      exp.save.should_not == true
    end
    it "should be valid" do
      exp.should_not be_valid
    end
  end
  
  context "latitude is assigned, longitude and primary_contact_name are unassigned" do
    let(:exp) { Experience.new :latitude => 2.0 }
    it "should be able to save" do
      exp.save.should_not == true
    end
    it "should be valid" do
      exp.should_not be_valid
    end
  end
  
  context "latitude, longitude and primary_contact_name are unassigned" do
    let(:exp) { Experience.new }
    it "should be able to save" do
      exp.save.should_not == true
    end
    it "should be valid" do
      exp.should_not be_valid
    end
  end
  
end
