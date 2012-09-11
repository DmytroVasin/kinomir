class AddCountryStateIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :country_id, :string
  	add_column :users, :state_id, :string
  end
end
