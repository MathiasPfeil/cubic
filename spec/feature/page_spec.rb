require 'spec_helper'

RSpec.feature Cubic::Application, :type => :feature do
  
  it 'gives param past in url' do
    visit('/pass/awesome_word')
    expect(page.has_text?('awesome_word')).to be(true)
  end
  
  it 'gives instance variables defined in controller' do
    visit('/test/instance_variables')
    expect(page.has_text?('instance_variable')).to be(true)
  end
  
  it 'returns url variable as integer when variable is a number' do
    visit('/user/add_one_to_id/5')
    expect(page.has_text?('id: 6')).to be(true)
  end
  
  it 'should allow redirect' do
    visit('/redirect_to_index')
    expect(page.has_text?('app/home/views/index.haml')).to eql(true)
  end
  
  it 'returns content-type as application/json' do
    visit('/render/json')
    expect(page.response_headers['content-type']).to match(/application\/json/)
  end
  
  it 'creates log' do
    visit('/log/log_this')
    log = File.expand_path('../../test_app/log/test.log', __FILE__)
    content = File.open(log, 'r').read
    expect(content).to match(/log_this/)
  end
  
  context 'controller' do
  
    it 'has access to model methods' do
      visit('/model/methods')
      expect(page.has_text?('Hello World')).to eq(true)
    end
  
  end
end
