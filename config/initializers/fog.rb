CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider   => 'Local',
      :local_root => '~/fog',
  }
end
