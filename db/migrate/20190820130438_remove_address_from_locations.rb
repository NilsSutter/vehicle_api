class RemoveAddressFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :address, :string
  end
end
