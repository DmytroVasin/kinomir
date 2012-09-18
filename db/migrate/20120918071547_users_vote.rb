class UsersVote < ActiveRecord::Migration
  	    def self.up
    	    create_table :users_votes, :id => false do |t|
      	       t.references :vote, :user
    	    end
  	    end
 
  	    def self.down
    	    drop_table :users_votes
	    end
end