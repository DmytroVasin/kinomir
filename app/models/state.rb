class State < ActiveRecord::Base
  has_many :users
  belongs_to :country
end
