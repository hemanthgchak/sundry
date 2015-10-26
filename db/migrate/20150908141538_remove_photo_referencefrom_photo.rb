class RemovePhotoReferencefromPhoto < ActiveRecord::Migration
  def change
  	remove_column :photos, :photo_reference, :string
  end
end
