module Cubic
  module Generator
    # Model fulfils the M in the MVC pattern. Files the Model generator
    # creates will include a class inheriting from the class your ORM
    # suggests.
    class Model < Base

      def initialize
        @migration = Migrations.new
        super()
      end

      # Creates a hash that will be used for file generation purposes
      def design(name, options = {})
        @migration.design(name, options)

        @files << { name: "#{name}.rb",
                    path: '/app/models',
                    content: format_model(name) }
        self
      end

      # Called after a file is successfully generated from hash
      # created by design method.
      def callback
        @migration.generate
      end

      # Allows user to specify code that should be included in
      # generated model file.
      # Example: add('has_many :users')
      def add(*code)
        code *= "\n"
        @files.last[:content] = insert_code(@files.last[:content], code)
      end

      private

      def format_model(name)
        "class #{model_name(name)} < #{orm_class}\n\nend".chomp
      end

      def model_name(name)
        name.to_s.split('_').map(&:capitalize).join('')
      end

      # Inserts code into the file to be generated.
      def insert_code(model, code)
        model.split(/(?<=#{orm_class})/).insert(1, code).join("\n")
      end

      # Returns what class should be inherted from based on ORM
      # specified in sitemap file.
      def orm_class
        case Config[:orm]
        when 'Sequel' || 'sequel'
          'Sequel::Model'
        else
          Config[:orm]
        end
      end
    end
  end
end
