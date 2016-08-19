require 'cubic/application/logable'
require 'cubic/application/configurator'
require 'cubic/application/controller'

module Cubic
  # A cubic application inherits from the Application
  # class, allowing it to change things such as
  # configuration options.
  class Application < Engine
    class << self

      # Requires all files from the generated application
      # during startup.
      def load_app
        start_load if load_acceptable?
      end

      # Allows configuration options to be set within
      # the config/application.rb file.
      def config
        Configurator
      end

      private

      def load_acceptable?
        !run_before? || development? ? has_run : false
      end

      def start_load
        prime_app
        Dir.glob(required_files).each { |f| load f }
      end

      def run_before?
        @run_before ||= false
      end

      def has_run
        @run_before = true
      end

      # Remove routes
      def prime_app
        Router.routes.clear
      end

      def development?
        ENV['name'] == 'development'
      end

      def required_files
        ctrls = File.join(config.root_dir, %w(app controllers *_controller.rb))
        lib_files = File.join(config.root_dir, %w(lib ** *))
        models = File.join(config.root_dir, %w(app models *.rb))

        [ctrls, lib_files, models]
      end
    end
  end
end
