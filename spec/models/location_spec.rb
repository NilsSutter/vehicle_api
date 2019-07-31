require 'rails_helper'

RSpec.describe Location, type: :model do
  # model should act_as_paranoid
  it { is_expected.to act_as_paranoid }
  # location should belong to vehicle
  it { should belong_to(:vehicle) }
  # when a new instance is created, lat and lng need to be present
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
end
