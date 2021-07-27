class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  
  #minimagickを使う
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog


  # 保存形式をJPGにする
  process :convert => 'jpg'

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [800, 800]
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  
  # テスト時の画像保存場所を指定
  def store_dir
    if Rails.env.test?
      "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # テスト時のキャッシュの保存場所を指定
  def cache_dir
    "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  　ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
