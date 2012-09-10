class AddCreatorofcommentToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :user_id, :integer
  	add_index :comments, :user_id
  	add_column :comments, :admin_id, :integer
  	add_index :comments, :admin_id
  end
end
