ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'
Bundler.require(ENV['BUNDLE_GEMFILE'])
