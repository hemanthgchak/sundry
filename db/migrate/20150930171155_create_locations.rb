class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :street
      t.string :address
      t.integer :pincode
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
