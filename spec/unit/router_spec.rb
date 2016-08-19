require 'spec_helper'

RSpec.describe Cubic::Router do
  
  let(:router) { Cubic::Router }
  
  before :each do
    block = Proc.new { 'hello world' }
    router.set_route('GET', '/router/spec', block)
  end
  
  it 'sets a route' do
    search = router.routes.find {|a| a[:route] == '/router/spec'}
    expect(search).to be_a(Hash)
  end
  
  it 'searches for valid route' do
    search = router.search('GET', '/router/spec')
    expect(search[:route]).to match(/\/router\/spec/)
  end
  
end
