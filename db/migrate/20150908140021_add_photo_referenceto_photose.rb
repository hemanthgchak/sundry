class AddPhotoReferencetoPhotose < ActiveRecord::Migration
  def change
  	add_column :photos, :photo_reference, :string
  end
end
