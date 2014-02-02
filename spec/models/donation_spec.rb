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
    it { should validate_presence_of(:donatable)}
  end
  
  describe "#associations" do
    it { should belong_to(:donatable) }
  end
  
  context "title, description and donatable are assigned" do
    let(:donation) { Donation.new :title => "Donation Test Title", :description => "This is test description for the donation", :donatable => Voucher.new(:expiration_date => 1.week.from_now) }
    it "should be able to save" do
      donation.save.should == true
    end
    it "should be valid" do
      donation.should be_valid
    end
  end
  
  context "title and donatable are assigned and description is unassigned" do
    let(:donation) { Donation.new :title => "Donation Test Title", :donatable => Voucher.new(:expiration_date => 1.week.from_now) }
    it "should not be able to save" do
      donation.save.should_not == true
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "title and description are assigned and donatable is unassigned" do
    let(:donation) { Donation.new :title => "Donation Test Title", :description => "This is test description for the donation" }
    it "should not be able to save" do
      donation.save.should_not == true
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "description and donatable are assigned and title is unassigned" do
    let(:donation) { Donation.new :description => "This is test description for the donation" }
    it "should not be able to save" do
      donation.save.should_not == true
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "description is assigned and title and donatable are unassigned" do
    let(:donation) { Donation.new :description => "This is test description for the donation" }
    it "should not be able to save" do
      donation.save.should_not == true 
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "title is assigned and description and donatable are unassigned" do
    let(:donation) { Donation.new :title => "Donation Test Title" }
    it "should not be able to save" do
      donation.save.should_not == true 
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "donatable is assigned and description and title are unassigned" do
    let(:donation) { Donation.new :donatable => Voucher.new(:expiration_date => 1.week.from_now) }
    it "should not be able to save" do
      donation.save.should_not == true 
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
  context "title, description and donatable are unassigned" do
    let(:donation) { Donation.new  }
    it "should not be able to save" do
      donation.save.should_not == true 
    end
    it "should not be valid" do
      donation.should_not be_valid
    end
  end
  
end
