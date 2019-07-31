require 'rails_helper'

RSpec.describe Location, type: :model do
  it { is_expected.to act_as_paranoid }
  it { should belong_to(:vehicle) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
end
