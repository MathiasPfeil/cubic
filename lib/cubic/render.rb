require 'json'

module Cubic
  # Render template is responsible for serving up files from the views directory.
  class Render
    include Logable
    attr_accessor :params
    attr_reader :template

    def initialize(params, block)
      @params = params
      instance_exec(&block)
    end

    private

    def render(render_method, path)
      send(render_method, path)
    end

    def redirect(url, status = 302)
      redir = proc do |response|
        response.redirect(url, status)
      end

      build_response(redir)
    end

    def html(path)
      build_response(read_file(path, 'html'))
    end

    def json(hash)
      build_response(JSON.generate(hash), 200, 'content-type' => 'application/json')
    end

    # Create a response that will satisfy Rack::Response
    def build_response(body, status = 200, headers = {})
      @template = { body: body, status: status, headers: headers }
    end

    def haml(path)
      haml = Haml::Engine.new(read_file(path, 'haml'))
      build_response(application_view { haml.render(self) })
    end

    def erb(path)
      build_response(ERB.new(read_file(path, 'erb')).result(binding))
    end

    def read_file(path, template_engine)
      File.read(File.join(view_path, "#{path}.#{template_engine}"))
    end

    # To keep things dry, application_view inserts HTML from a rendered
    # view into the app/views/layout/application.haml file.
    def application_view(&block)
      template = read_file('layout/application', 'haml')
      Haml::Engine.new(template).render(self, &block)
    end

    # Returns the absolute path to the applications views directory.
    def view_path
      File.join(APP_PATH, 'app/views')
    end
  end
end
