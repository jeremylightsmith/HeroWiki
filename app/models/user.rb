require 'digest'

class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth_hash)
    provider, uid, name, email = auth_hash[:provider], auth_hash[:uid], auth_hash[:info][:name], auth_hash[:info][:email]

    user = User.where(provider:provider, uid:uid).first
    if user
      user.name = name if name
      user.email = email if email
      user.save! if user.changed?
    else
      user = User.create!(provider:provider, uid:uid, name:name, email:email)
    end
    user
  end

  def url
    name.urlify
  end
end
