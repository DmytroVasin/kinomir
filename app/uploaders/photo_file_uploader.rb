class PhotoFileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/all_uploaded_photo/#{model.post.id}"
  end
  version :thumb do
    process :resize_to_fill => [120, 120]
  end
  
#  сортировать по ширене а не по высоте !!!
  version :medium do
    process :resize_to_fit => [800, nil]
    
  end
# убрать gif формат
  def extension_white_list
    %w(jpg jpeg png)
  end
  


end
