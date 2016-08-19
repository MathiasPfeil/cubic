# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cubic/version'

Gem::Specification.new do |spec|
  spec.name          = "cubic"
  spec.version       = Cubic::VERSION
  spec.authors       = "Mathias Pfeil"
  spec.email         = "mathiaspfeil@yahoo.com"
  spec.homepage      = "https://github.com/Scootin/cubic"
  spec.summary       = "Small framework built with a focus on quick app generation."
  spec.description   = "Small framework built with a focus on quick app generation."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir['Gemfile', 'LICENSE.md', 'README.md', 'Rakefile', 'lib/**/**/*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'rack', '~> 2.0', '>= 2.0.1'
  spec.add_dependency 'json', '~> 1.8', '>= 1.8.3'
  spec.add_dependency 'sequel', '~> 4.36'
  spec.add_dependency 'haml', '~> 4.0', '>= 4.0.7'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'capybara', '~> 2.7', '>= 2.7.1'
  spec.add_development_dependency 'rspec', '~> 3.4'
end
