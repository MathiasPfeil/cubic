require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'capybara/rspec'
require 'cubic'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

Capybara.configure do |config|
  config.app = Rack::Builder.parse_file(File.expand_path('../test_app/config.ru', __FILE__)).first
end
