class CreateRadarSearches < ActiveRecord::Migration
  def change
    create_table :radar_searches do |t|
      t.decimal :lat
      t.decimal :long
      t.string :g_id
      t.string :place_id

      t.timestamps null: false
    end
  end
end
