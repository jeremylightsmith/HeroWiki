source 'https://rubygems.org'

gem 'rails', '3.2.2'

gem "omniauth"
gem "omniauth-openid"
#gem "omniauth-twitter"
#gem "omniauth-facebook"
#gem "omniauth-google"

gem 'jquery-rails'
gem 'RedCloth', '>= 4.2.9'
gem "will_paginate", "~> 3.0.pre2"
gem 'airbrake'
gem "dalli"
gem 'thin'
gem "paperclip", "~> 2.3"
gem 'aws-sdk'
gem "differ"

gem 'twitter-bootstrap-rails'

group :assets do
  gem "therubyracer"
  gem "less-rails"
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem "pg"
  gem 'newrelic_rpm'
end

group :development, :test do
  gem "heroku"
  gem "sqlite3"
  gem "taps"
  gem "rspec-rails"
  gem "spork"
  gem "guard-rspec"
end
