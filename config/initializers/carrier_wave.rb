CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog                        
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['aws_key_id'],     
      aws_secret_access_key: ENV['aws_secret_key'], 
      region:                'us-east-1',                
    }
    config.fog_directory = 'shop-store'
  else
    config.storage :file
  end
end