class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_file
      t.references :post

      t.timestamps
    end
    add_index :photos, :post_id
  end
end
