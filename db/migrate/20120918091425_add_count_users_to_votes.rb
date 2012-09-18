class AddCountUsersToVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :count_users, :integer, :default => 0  	
  end
end
