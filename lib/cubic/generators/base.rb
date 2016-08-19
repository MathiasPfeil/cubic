require 'fileutils'

module Cubic
  module Generator
    # All generators (model, view, controller) inherit from the base class.
    class Base
      attr_reader :files

      def initialize
        @files = []
      end

      # If callback is not defined within a generator, this method
      # will be called to avoid a 'NoMethodError'.
      def callback; end

      # Generate takes an array of hashes from each generator,
      # then creates a file from those params.
      # If a generator requires a unique file generation,
      # this method will be overwritten in that file.
      def generate
        @files.each do |info|
          path = File.join(Config[:root_path], info[:path])

          FileUtils.mkdir_p(path) unless File.directory?(path)

          full_path = File.join(path, info[:name])
          File.open(full_path, 'w') { |f| f.write(info[:content]) }
        end
        callback
      end
    end
  end
end
