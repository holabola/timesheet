class ExpenseUploader < CarrierWave::Uploader::Base

   #Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
   version :large, :if => :image? do
     process resize_to_fit: [1000, 1000]
   end
  #
  # def scale(width, height)
  #   # do something
  # end
   version :printable, :if => :image? do
     process resize_to_fit: [280,1000]
   end

  # Create different versions of your uploaded files:
   version :thumb, :if => :image? do
     process resize_to_fit: [200, 200]
   end

   version :pdf, :if => :pdf? do
       process :convert => 'jpg'
       process :resize_to_fit => [560,1000]
       process :set_content_type

       def full_filename (for_file = model.file.file)
         "#{model.id}-thumb.jpg"
       end
   end


   def pdf?(new_file)
     MIME::Types.any? { |type| type.content_type == 'application/pdf' }
   end
   def set_content_type(*args)
     self.file.instance_variable_set(:@content_type, "image/jpeg")
   end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_whitelist
     %w(jpg jpeg gif png pdf)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

   protected

   def image?(new_file)
     new_file.content_type.include? 'image'
   end

end
