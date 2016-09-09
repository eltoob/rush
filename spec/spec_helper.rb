$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rush'

RSpec.configure do |config|
  config.before(:each) do
    Rush.reset
  end
end
