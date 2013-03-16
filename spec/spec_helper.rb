ENV['RACK_ENV'] = 'test'
require_relative '../app'
require 'rack/test'
include Rack::Test::Methods

set :environment, :test

def app                  
 Sinatra::Application
end

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true        
  config.include Rack::Test::Methods
end
