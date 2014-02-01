class Voucher < ActiveRecord::Base
  has_one :donation, :as => :donatable
  attr_accessible :expiration_date
  validates_presence_of :expiration_date
end
