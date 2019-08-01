require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  # model should act_as_paranoid
  it { is_expected.to act_as_paranoid }
  # ensure model has a 1:N relationship with locations
  it { should have_many(:locations).dependent(:destroy) }
  # validates id to be present
  it { should validate_presence_of(:id) }
end
