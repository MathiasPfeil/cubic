require 'spec_helper'

RSpec.describe Cubic::Generator::Config do
  
  let(:config) {Cubic::Generator::Config}

  it 'uses default config options' do
    defaults = { name: 'No Name', test_type: 'rspec', orm: 'Sequel', db: 'sqlite3', html_type: 'haml', css_type: 'css' }
    real = defaults.keys.map! { |f| config.defaults(f) == defaults[f] ? true : false }
    expect(real.include?(false)).to be(false)
  end
end