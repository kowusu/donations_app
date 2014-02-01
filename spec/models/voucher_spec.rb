require 'spec_helper'

describe Voucher do
  
  describe "#fields" do
    it { should respond_to(:expiration_date) }
  end
  
  describe "#validations" do
    it { should validate_presence_of(:expiration_date) }
  end
  
  describe "#associations" do
    it { should have_one(:donation) }
  end
  
  context "expiration_date is assigned" do
    let(:voucher) { Voucher.new :expiration_date => Time.now }
    it "should be able to save" do
      voucher.save.should == true
    end
    it "should be valid" do
      voucher.should be_valid
    end
  end
  
  context "expiration_date is unassigned" do
    let(:voucher) { Voucher.new }
    it "should not be able to save" do
      voucher.save.should_not == true
    end
    it "should not be valid" do
      voucher.should_not be_valid
    end
  end
  
end
