APP_PATH = File.expand_path('../..', __FILE__)
VIEW_PATH = APP_PATH

ENV['name'] = 'test'

require 'cubic'

Cubic.application.load_app

module TestApp
  class Application < Cubic::Application

    config.template_engine = :haml

  end
end