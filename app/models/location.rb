class Location < ApplicationRecord
  reverse_geocoded_by :lat, :lng
  after_validation :reverse_geocode
  belongs_to :vehicle
end
