class Comment < ActiveRecord::Base
  attr_accessible :body
  belongs_to :post
  belongs_to :user


  validates :body, :presence => true, :length => { :minimum =>  2 }
end
