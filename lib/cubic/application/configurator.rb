module Cubic
  # Configuration stores details given during startup.
  class Configurator
    class << self
      attr_accessor :template_engine

      def design
        yield self
      end

      def root_dir
        APP_PATH
      end
    end
  end
end
