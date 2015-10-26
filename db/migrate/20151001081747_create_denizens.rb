class CreateDenizens < ActiveRecord::Migration
  def change
    create_table :denizens do |t|
      t.integer :location_id
      t.string :dweller_type
      t.integer :dweller_id

      t.timestamps null: false
    end
  end
end
