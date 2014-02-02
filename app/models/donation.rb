class Donation < ActiveRecord::Base
  belongs_to :donatable, :polymorphic => true
  attr_accessible :description, :donatable, :title
  validates_presence_of :title, :description, :donatable
end
