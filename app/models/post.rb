class Post < ActiveRecord::Base
  attr_accessible :text, :title, :category_ids

  has_and_belongs_to_many :categories

  has_many :comments, :dependent => :destroy
  belongs_to :user
  belongs_to :admin
  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :text, :presence => true, :length => { :minimum => 2 }

  scope :by_category_id, lambda {|cid| joins(:categories).where(['categories.id = ?',cid])}

end
