require 'spec_helper'

require "rack/file"
require "rack/utils"

RSpec.describe Cubic::Static do
  
  let(:app) { proc{[200,{},['Hello, world, sunny.']]} }
  let(:path) { File.expand_path('../../test_app/public', __FILE__) }
  let(:stack) { Cubic::Static.new(app, url: ['/stylesheets', '/javascripts'], root: path) }
  let(:request) { Rack::MockRequest.new(stack) }
  
  let(:response) { request.get('/stylesheets/application.css') }
  
  it 'accepts url as array' do
    expect(response.headers['Content-Type']).to match('text/css')
  end
  
end
