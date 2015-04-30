# Amazon's AWS service is returning an error related to region when trying to store images.  Doesn't seem to be a bug on this end.

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',
    region:                 ENV['AWS_REGION'], 
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY']
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public     = true
end