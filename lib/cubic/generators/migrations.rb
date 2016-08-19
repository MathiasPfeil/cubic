module Cubic
  module Generator
    # Generates the migrations for columns and rows attached to a model.
    class Migrations < Base

      # Creates a hash that will be used for file generation purposes
      def design(name, options)
        @files << { name: "create_#{name}.rb",
                    path: '/db/migrations/',
                    content: "DB.create_table :#{name.to_s.concat('s')} do
                      primary_key :id
                      #{pair(options)}
                    end" }
      end

      private

      # Example: {email: :string} turns into 't.string :email'
      def pair(options)
        options.keys.map { |f| "#{options[f].capitalize} :#{f}" }.join("\n")
      end
    end
  end
end
