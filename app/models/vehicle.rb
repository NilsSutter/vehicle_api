class Vehicle < ApplicationRecord
  has_many :locations, dependent: :destroy
end
