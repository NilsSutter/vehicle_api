class Vehicle < ApplicationRecord
  # upon delete requests, records will just be hidden but are still available for future analysis purposes
  # call 'really_destroy!' to delete a record from the database
  # call 'only_deleted' to get access to all soft-deleted records
  # call 'restore(id, :recursive => true)' to restore a record with their associated records
  acts_as_paranoid
  has_many :locations, dependent: :destroy
end
