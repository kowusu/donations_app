class PhysicalItem < ActiveRecord::Base
  has_one :donation, :as => :donatable
  attr_accessible :height, :weight, :width
  
  validates_presence_of :height, :weight, :width
end
