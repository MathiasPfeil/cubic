require 'rack/file'
require 'rack/utils'

module Cubic
  # Replaces the Rack::Static module as was unreliable for
  # this application.
  class Static

    def call(env)
      if valid_route(env['PATH_INFO'])
        @file.call(env)
      else
        @app.call(env)
      end
    end

    def initialize(app, options = {})
      @app  = app
      @url  = options[:url]
      root  = options[:root] || Dir.pwd

      @file = Rack::File.new(root)
    end

    def valid_route(path)
      if @url.is_a? Array
        ar = @url.map { |u| path.include?(u) ? true : false }
        ar.include? true
      else
        path.include?(@url) ? true : false
      end
    end
  end
end
