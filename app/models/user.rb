class User < ActiveRecord::Base

  before_create :create_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable ,:recoverable,
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :country_id, :state_id, :terms_of_service, :role_ids
  # attr_accessible :title, :body
  has_many :posts
  has_many :comments

  has_and_belongs_to_many :roles

  belongs_to :country
  belongs_to :state
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :email, :presence => true
  validates :terms_of_service, :acceptance => true


  private
    def create_role
      self.roles << Role.find_by_name(:user)  
    end

end
