module Cubic
  module Generator
    # Creates a Gemfiles in the root directory of the generated application.
    class Gemfile < Base

      # Creates a hash that will be used for file generation purposes
      def design
        group = ['source "https://rubygems.org"',
                 'gem "sinatra"',
                 'gem "rake"',
                 'gem "sequel"',
                 'gem "haml"']

        gems = [Config[:gems], Config[:orm], Config[:db]].flatten.compact
        gems.map! { |gem| "gem '#{gem}'" }

        @files << { name: 'Gemfile',
                    path: '/',
                    content: gems.unshift(group).flatten!.join("\n") }
      end
    end
  end
end
