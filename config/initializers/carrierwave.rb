require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.cache_storage = :file
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAVOFJAHPFGFENZ7HS',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }
    config.fog_directory  = 'myt-aws-bucket-2'
    config.cache_storage = :fog
  end
end