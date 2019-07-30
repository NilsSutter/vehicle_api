class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations, id: :uuid do |t|
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
