require 'spec_helper'

RSpec.describe Cubic::Configurator do

  it 'accepts configuration information' do
    Cubic::Configurator.design do |config|
      config.template_engine = 'haml'
    end
    expect(Cubic::Configurator.template_engine).to match('haml')
  end
  
end
