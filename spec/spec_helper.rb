require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  #require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include UsersSupport
  end

  module RSpec
    module Core
      class ExampleGroup
        def self.as_editor
          before do
            #sign_in create_admin!
          end
        end
      end
    end
  end
end

Spork.each_run do
  require File.expand_path("../../config/routes", __FILE__)
end
