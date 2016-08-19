require File.expand_path('../config/application', __FILE__)
pathh = File.join(APP_PATH, 'public')

# Default middleware
use Cubic::Static, url: ['/stylesheets', '/javascripts'], root: pathh

run Cubic.application
