class Post < ActiveRecord::Base
  attr_accessible :text, :title
  has_many :comments, :dependent => :destroy
  belongs_to :user
  belongs_to :admin
  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :text, :presence => true, :length => { :minimum => 2 }
end
