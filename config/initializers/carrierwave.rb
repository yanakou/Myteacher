require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAVOFJAHPFJSHWYUHA',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }
    config.fog_directory  = 'myt-aws-bucket'
    config.asset_host = 'https://myt-aws-bucket.s3.amazonaws.com'
  end
end