class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :phone_no
      t.decimal :lat
      t.decimal :long
      t.string :street_no
      t.string :route
      t.string :nb
      t.string :sl_3
      t.string :sl_2
      t.string :sl_1
      t.string :locality
      t.string :aal_2
      t.string :aal_1
      t.string :country
      t.string :pincode
      t.string :place_id
      t.string :types
      t.string :photoreference

      t.timestamps null: false
    end
  end
end
