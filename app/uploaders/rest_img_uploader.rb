# encoding: utf-8

class RestImgUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

	# for Korean image file names
	CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

	version :big_size do
		process :resize_to_limit => [600, 337.5]
		process :quality => 90 
	end	

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
