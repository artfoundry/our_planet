$LOAD_PATH.unshift(File.expand_path('./app'))
ENV['RACK_ENV'] = 'test'
require 'config'
require 'rack/test'


set :raise_errors, true
set :dump_errors, false
set :show_exceptions, false

module FeatureSpec
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def session
    last_request.env['rack.session']
  end
end
