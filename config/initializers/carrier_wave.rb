CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => ENV['GOOGLE_STORAGE_ID'],
    :google_storage_secret_access_key => ENV['GOOGLE_STORAGE_KEY']
  }
  config.fog_directory = 'parkmap-image'
end
