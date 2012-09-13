class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable ,:recoverable,
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :country_id, :state_id, :terms_of_service
  # attr_accessible :title, :body
  has_many :posts
  has_many :comments

  belongs_to :country
  belongs_to :state
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :email, :presence => true
  validates :terms_of_service, :acceptance => true

end
