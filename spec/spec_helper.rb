$LOAD_PATH.unshift File.expand_path('..', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'oauth2_dingtalk'
require 'rspec'
require 'omniauth'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
