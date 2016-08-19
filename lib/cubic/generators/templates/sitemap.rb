Cubic.run do |construct|

  construct.config do |config|
    # Your configuration block will set the defaults for
    # your application.These options are not set in stone,
    # but this file is an easy way to get an overview
    # of your app, so it is best to try and follow
    # what you have specified here!

    # Below are the default options when generating your application.
    #
    # Your root_path will set the directory you wish
    # your application generated within.
    config.root_path  = Dir.getwd

    # As of now, only Sequel and ActiveRecord are the only ORMs supported.
    config.orm        = 'Sequel'

    # Select your prefered database.
    config.db         = 'sqlite3'

    # Choose your templating engine.
    config.html_type  = 'haml'
    config.css_type   = 'css'

    # Add gems you will require
    config.gems       = []
  end

  construct.models do |model|
    # Create -or 'design'- your models within this block.
    # model.design(:user, {some: 'structure'}).add('has_secure_password')
  end

  construct.controllers do |c|
    # List your controllers to be generated.
    c.design(:home).routes(:index)
    c.design(:user).routes(:new)
    c.design(:sessions)
    c.design(:static)
  end
end
