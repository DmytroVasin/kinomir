class Comment < ActiveRecord::Base
	before_validation :check_for_spaces
  attr_accessible :body
  belongs_to :post
  belongs_to :user


  validates :body, :presence => true, :length => { :minimum =>  2 }


  def check_for_spaces
  	self.body = self.body.strip
  end
end
