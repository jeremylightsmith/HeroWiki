require 'omniauth-openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp'), :name => "google", :identifier => "https://www.google.com/accounts/o8/id"
  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp'), :name => "yahoo", :identifier => "https://me.yahoo.com"
end

