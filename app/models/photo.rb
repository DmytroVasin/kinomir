class Photo < ActiveRecord::Base
  attr_accessible :photo_file, :post_id
  belongs_to :post

  # mount_uploader :photo_file, PhotoFileUploader

 	mount_uploader :photo_file, PhotoFileUploader


end
