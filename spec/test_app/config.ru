require "rack/file"
require "rack/utils"

#module Cubic
#  class Static
#
#    # Make sure this middleware will also take an array of different urls that it will search within pubic folder for
#    # Example: Cubic::Static, url: ['/stylesheets', '/js', '/imgs'], root: 'some/path'
#    
#    def call(env)
#      if valid_route(env['PATH_INFO'])
#        response = @file.call(env)
#        Rack::Response.new(response)
#      else
#        @app.call(env)
#      end
#    end
#    
#    def initialize(app, options = {})
#      @app  = app
#      @url  = options[:url]
#      root  = options[:root] || Dir.pwd
#      
#      @file = Rack::File.new(root)
#    end
#    
#    def valid_route(path)
#      @url == path ? true : false
#    end
#    
#  end
#end

require File.expand_path('../config/application', __FILE__)
pathh = File.join(APP_PATH, 'public')

# Default middleware
use Cubic::Static, url: '/stylesheets/application.css', root: pathh

run Cubic.application
