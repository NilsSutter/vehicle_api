class Location < ApplicationRecord
  reverse_geocoded_by :lat, :lng
  after_validation :reverse_geocode
  acts_as_paranoid
  belongs_to :vehicle
  validates :lat, :lng, presence: true
end
