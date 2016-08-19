require 'fileutils'

module Cubic
  module Generator
    # App is the last stop in the generation process. Once all generator
    # instances have successfully dealt with the information given
    # to them, they are sent here so they can turn that information
    # into files, which are inserted into the generated application.
    class App < Base
      extend FileUtils

      class << self
        def create(*generators)
          directories
          static_files
          insert_generated_files(generators)
          extra_files
        end

        private

        # Creates default structure of appliction
        def directories
          structure = ['/app/views/layout', '/bin', '/config', '/db/migrations',
                       '/public/stylesheets', '/public/javascripts', '/spec']
          structure.each { |f| mkdir_p(Config[:root_path] + f) }
        end

        # Calls on all generators to turn their stored data into files
        def insert_generated_files(generators)
          generators.each(&:generate)
        end

        # Fills the application with nondynamic files, which can be
        # found in the templates directory
        def static_files
          wd = File.expand_path('../', __FILE__)

          file_and_path = { 'cubic'            => 'bin',
                            'config.ru'        => '/',
                            'application.haml' => '/app/views/layout',
                            'application.rb'   => '/config',
                            'boot.rb'          => '/config',
                            'Rakefile'         => '/',
                            'database.rb'      => '/db',
                            'application.css'  => '/public/stylesheets',
                            'application.js'   => '/public/javascripts' }

          file_and_path.keys.each do |k|
            path = File.join(Config[:root_path], file_and_path[k])
            if File.exist?("#{wd}/templates/#{k}")
              FileUtils.cp("#{wd}/templates/#{k}", File.join(path, k))
            else
              File.open(File.join(path, k), 'w').close
            end
          end
        end

        # Creates Gemfile
        def extra_files
          gemfile = Gemfile.new
          gemfile.design
          gemfile.generate
        end
      end
    end
  end
end
