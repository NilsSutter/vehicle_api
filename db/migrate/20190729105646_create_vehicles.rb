class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles, id: :uuid do |t|

      t.timestamps
    end
  end
end
