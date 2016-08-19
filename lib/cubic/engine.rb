require 'cubic/router'
require 'erb'

module Cubic
  # Engine is what makes Cubic a Rack application.
  class Engine

    def self.call(env)
      new(env).response.finish
    end

    def initialize(env)
      @request = Rack::Request.new(env)
    end

    def response
      Application.load_app
      if search_routes
        Response.new render
      else
        Response.new(status_404)
      end
    end

    private

    def status_404
      { body: 'not found', status: 404 }
    end

    # Combines the params generated when checking routes
    # with the params given by Rack::Request.
    def merge_params
      @request.params.merge(Router.params)
    end

    # Render a view.
    def render
      Render.new(merge_params, @content[:block]).template
    end

    # Checks if path given by Rack::Request matches
    # any defined routes.
    def search_routes
      route = Router.search @request.request_method, @request.path
      route ? @content = route : nil
    end
  end
end
