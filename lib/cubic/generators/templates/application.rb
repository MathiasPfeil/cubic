APP_PATH = File.expand_path('../..', __FILE__)
ENV['NAME'] = 'development'

require File.join(APP_PATH, 'db/database')

require 'cubic'

Cubic.application.load_app

module TestApp
  class Application < Cubic::Application

  end
end
