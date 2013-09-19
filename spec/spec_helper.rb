$LOAD_PATH.unshift(File.expand_path('./app'))
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
end
