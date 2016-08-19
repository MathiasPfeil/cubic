require 'rack'
require 'haml'
require 'erb'

require 'cubic/version'
require 'cubic/core_extensions'
require 'cubic/engine'
require 'cubic/application'
require 'cubic/render'
require 'cubic/generator'
require 'cubic/router'
require 'cubic/response'

require 'cubic/middleware/static'

# Cubic is a small framework built on the idea of quick generation using templates.
module Cubic
  class << self

    # First method to be called in the generation process.
    def sitemap(&block)
      Generator.run(&block)
    end

    def application
      @app ||= Application
    end
  end
end
