require 'spec_helper'

RSpec.feature Cubic::Application, :type => :feature do
  
  it '/ returns index' do
    visit('/')
    expect(page.status_code).to eql(200)
  end
  
  it 'returns 200 for valid route' do
    visit('/index')
    expect(page.status_code).to be(200)
  end
  
  it 'renders html' do
    visit('/html')
    expect(page.status_code).to be(200)
  end
  
  it 'renders erb' do
    visit('/erb')
    expect(page.status_code).to be(200)
  end

  it 'allows routes to use wild cards through regex' do
    visit('/regex/hello')
    expect(page.status_code).to be(200)
  end
  
  it 'uses render method' do
    visit('/test/render')
    expect(page.status_code).to be(200)
  end

  it 'returns 404 for invalid route' do
    visit('/some/invalid/route')
    expect(page.status_code).to be(404)
  end
  
  it 'doesn\'t allow user to GET a POST route' do
    visit('/cannot_get')
    expect(page.status_code).to be(404)
  end
  
  it 'namespaces routes inside namespace block' do
    visit('/home/login')
    expect(page.status_code).to be(200)
  end
  
  it 'allows for params inside specified route' do
    visit('/logout/1')
    expect(page.status_code).to be(200)
  end
  
  it 'should load stylesheet' do
    visit('/stylesheets/application.css')
    expect(page.status_code).to eql(200)
  end
end