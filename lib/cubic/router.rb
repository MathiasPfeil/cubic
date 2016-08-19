module Cubic
  String.include CoreExtensions::Parse

  # Handles whether or not the path, given by Rack::Request,
  # matches any of the routes defined within the application.
  class Router
    class << self

      # Stores all of the routes for the application.
      def routes
        @route ||= []
      end

      # Adds a route to the routes array.
      def set_route(http_method, route, block)
        routes << { http_method: http_method, route: route, block: block }
      end

      # Searches url against defined routes. If none are found, we check
      # if the url fits the pattern of a route containing variables.
      def search(http, url)
        url = root_path?(url)
        route = routes.find { |i| i[:http_method] == http && i[:route] == url }
        route ? route : check_variable_routes(url, http)
      end

      # Stores parameters created when variable_route? finds a match.
      def params
        @param ||= {}
      end

      private

      def root_path?(url)
        url == '/' ? 'index' : url
      end

      # Creates a hash of parameters from variables supplied in the url
      # and merges them into the params hash given by Rack::Request.
      def create_param(key, value)
        return params[to_symbole(key)] = value.to_i if value.integer?
        params[to_symbole(key)] = value
      end

      # Turns a string preceeded by a colon into a symbole.
      # ':id'.to_sym would result in ::id, so we must remove
      # any colons first.
      def to_symbole(string)
        string.delete(':').to_sym
      end

      # Checks all routes that may have a variable; e.g. /post/:variable
      def check_variable_routes(url, http)
        routes.find do |i|
          i[:http_method] == http && variable_route?(i[:route], url)
        end
      end

      # variable_route? compares all routes against the url again,
      # but allows the url to fit into a 'variable route' if
      # one is found that matches the url pattern.
      def variable_route?(route, url)
        route = route.split('/').reject(&:empty?)
        url   = url.split('/').reject(&:empty?)

        after = route.zip(url).map do |r, u|
          r.nil? || u.nil? ? false : route_parser(r, u)
        end

        after.include?(false) ? false : true
      end

      # Checks if route can be turned into a variable.
      def route_parser(route, url)
        if route.include?(':')
          create_param(route, url)
        elsif route == url
          true
        else
          false
        end
      end
    end
  end
end
