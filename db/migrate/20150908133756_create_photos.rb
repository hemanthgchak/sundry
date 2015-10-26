class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.string :place_id
      t.string :attribution

      t.timestamps null: false
    end
  end
end
