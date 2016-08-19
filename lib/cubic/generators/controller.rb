module Cubic
  module Generator
    # Controller fulfils the C in the MVC pattern. Files the Model generator
    # creates will include a class inheriting from the CubicController.
    class Controller < Base

      def initialize
        @view = View.new
        super()
      end

      # Creates a hash that will be used for file generation purposes
      def design(name, options = {})
        if options[:actions] && options[:actions].any?
          actions = options[:actions]
          create_views(name, actions)
        else
          actions = []
        end

        @files << { name: "#{name}_controller.rb",
                    path: '/app/controllers/',
                    content: build_controller(name, actions) }
        self
      end

      private

      def create_views(name, actions)
        actions.each do |a|
          @view.design(name, a)
        end
      end

      # Called after the Controller generated has created its files.
      def callback
        @view.generate
      end

      def build_controller(name, actions)
        "#{controller_name(name)} < Cubic::CubicController\n#{build_actions(name, actions)}\nend"
      end

      def build_method(name, a)
        "\n#{tab}get '#{a}' do\n#{tab}\s\shaml '#{name}/#{a}'\n#{tab}end\n"
      end

      def controller_name(name)
        "class #{name.to_s.split('_').map(&:capitalize).join('')}Controller"
      end

      def build_actions(name, actions)
        actions.map! do |a|
          build_method(name, a)
        end
        "\s\snamespace '#{name}' do\n#{actions.join}\n\s\send"
      end

      def tab
        "\s" * 4
      end
    end
  end
end
