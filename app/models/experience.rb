class Experience < ActiveRecord::Base
  has_one :donation, :as => :donatable
  #attr_accessible :latitude, :location, :longitude, :primary_contact_name
  validates_presence_of :longitude, :primary_contact_name, :latitude
  geocoded_by :location
  after_validation :geocode, :if => :location_changed?
end
