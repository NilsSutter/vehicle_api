class AddVehiclesToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :vehicle, type: :uuid, foreign_key: true
  end
end
