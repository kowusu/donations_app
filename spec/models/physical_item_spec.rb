require 'spec_helper'

describe PhysicalItem do
  describe "#fields" do
    it { should respond_to(:height) }
    it { should respond_to(:weight) }
    it { should respond_to(:width) }
  end
  
  describe "#validations" do
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:width) }
  end
  
  describe "#associations" do
    it { should have_one(:donation) }
  end
  
  context "height, weight, and width are assigned" do
    let(:physical_item) { PhysicalItem.new :height => 10, :weight => 10, :width => 10 }
    it "should be able to save" do
      physical_item.save.should == true
    end
    it "should be valid" do
      physical_item.should be_valid
    end
  end
  
  context "height and weight are assigned, and width is unassigned" do
    let(:physical_item) { PhysicalItem.new :height => 10, :weight => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  context "height and width are assigned, and weight is unassigned" do
    let(:physical_item) { PhysicalItem.new :height => 10, :width => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  context "weight and width are assigned, and height is unassigned" do
    let(:physical_item) { PhysicalItem.new :width => 10, :weight => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  context "weight is assigned, and height and width are unassigned" do
    let(:physical_item) { PhysicalItem.new :weight => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  context "height is assigned, and  weight and width are unassigned" do
    let(:physical_item) { PhysicalItem.new :height => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  context "width is assigned, and height and weight are unassigned" do
    let(:physical_item) { PhysicalItem.new :width => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  context "width, height and weight are unassigned" do
    let(:physical_item) { PhysicalItem.new :width => 10 }
    it "should be able to save" do
      physical_item.save.should_not == true
    end
    it "should be valid" do
      physical_item.should_not be_valid
    end
  end
  
  
end
