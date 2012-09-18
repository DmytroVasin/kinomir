class Vote < ActiveRecord::Base
  attr_accessible :score, :count_users
  has_and_belongs_to_many :users
  belongs_to :post
end
