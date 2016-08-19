require 'spec_helper'

RSpec.describe Cubic::CubicController do
  
  let(:app)    { Cubic::CubicController }
  let(:routes) { Cubic::Router.routes }
  
  after :each do
    app.namespace = nil
    routes.clear
  end

  context 'creates route with' do
    
    it 'GET http method' do
      app.get('/index/get') {'hello'}
      route = routes.find { |r| r[:route] == '/index/get' }
      expect(route).to be_a(Hash)
    end
    
    it 'POST http method' do
      app.post('/index/post') {'hello'}
      route = routes.find { |r| r[:route] == '/index/post' }
      expect(route).to be_a(Hash)
    end
    
    it 'PUT http method' do
      app.put('/index/put') {'hello'}
      route = routes.find { |r| r[:route] == '/index/put' }
      expect(route).to be_a(Hash)
    end
    
    it 'DELETE http method' do
      app.delete('/index/delete') {'hello'}
      route = routes.find { |r| r[:route] == '/index/delete' }
      expect(route).to be_a(Hash)
    end
    
  end
  
  it 'adds namespace' do
    app.namespace = 'home'
    np = app.namespace_url('index')
    expect(np).to match('home/index')
  end
  
end
