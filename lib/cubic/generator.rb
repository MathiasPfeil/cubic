require_relative 'generators/config'
require_relative 'generators/base'
require_relative 'generators/controller'
require_relative 'generators/model'
require_relative 'generators/migrations'
require_relative 'generators/gemfile'
require_relative 'generators/view'
require_relative 'generators/app'

module Cubic
  # The generator is what reads your sitemap file
  # and generates the proper files.
  module Generator
    class << self

      # Begins the generation process by running the block
      # given from sitemap.rb file.
      def run(&b)
        @model      = Model.new
        @controller = Controller.new
        @gemfile    = Gemfile.new

        instance_exec(&b)
        App.create(@model, @controller, @gemfile)
      end

      private

      def config(&b)
        Config.instance_exec(&b)
      end

      def models(&b)
        @model.instance_exec(&b)
      end

      def controllers(&b)
        @controller.instance_exec(&b)
      end
    end
  end
end
