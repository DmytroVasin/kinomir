class Post < ActiveRecord::Base

  after_create :create_vote

  attr_accessible :text, :title, :category_ids, :image

  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_one :vote, :dependent => :destroy
# -----------------------------------------------
  has_many :photos, :dependent => :destroy 
# -----------------------------------------------

  belongs_to :user

  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :text, :presence => true, :length => { :minimum => 2 }
  
  scope :by_category_id, lambda {|cid| joins(:categories).where(['categories.id = ?',cid])}

  mount_uploader :image, ImageUploader
  


include PgSearch
pg_search_scope :search, against: [:title, :text],
	associated_against: {user: :name, comments: [:body]}

# end of 343 DB search in testing and production

	def self.text_search(query)
	  if query.present?
	    search(query)
	  else
	    scoped
	  end
	end

    protected
    
    def create_vote
      self.vote = Vote.create(:score => 0)
    end



end
