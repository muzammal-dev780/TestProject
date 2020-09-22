# frozen_string_literal: true

# AvatarUploader
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'default-avatar.gif'].compact.join('_'))
  end
  version :thumb do
    process resize_to_fit: [50, 50]
  end
  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
