module Cubic
  module Generator
    # Config stores data needed throughout the generation process.
    class Config

      @settings = {}

      class << self

        def all
          @settings
        end

        def [](key)
          all[key] || defaults(key)
        end

        def root_path(path)
          @settings[:root_path] = path
        end

        # Name of the application
        def name(name)
          @settings[:name] = name
        end

        # Prefered testing framework.
        def test_type(type)
          @settings[:test_type] = type || 'Rspec'
        end

        def orm(orm)
          @settings[:orm] = orm || 'Sequel'
        end

        def db(db)
          @settings[:db] = db || 'sqlite3'
        end

        # Consider renaming to 'template engine'
        def html_type(type)
          @settings[:html_type] = type || 'haml'
        end

        def css_type(type)
          @settings[:css_type] = type || 'css'
        end

        # Gems to be added to Gemfile
        def gems(gems)
          @settings[:gems] = gems
        end

        # Default options.
        def defaults(name)
          { root_path: Dir.getwd,
            name: 'No Name',
            test_type: 'rspec',
            orm: 'Sequel',
            db: 'sqlite3',
            html_type: 'haml',
            css_type: 'css' }[name]
        end
      end
    end
  end
end
