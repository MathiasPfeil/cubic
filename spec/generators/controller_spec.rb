require 'spec_helper'

RSpec.describe Cubic::Generator::Controller do
  
  before :each do
    @controller = Cubic::Generator::Controller.new
  end
  
  it 'creates record to be generated' do
    @controller.design(:home)
    expect(@controller.files.size).to eql(1)
  end
  
  it 'returns self' do
    expect(@controller.design(:home)).to eql(@controller)
  end
  
  it 'adds methods to file' do
    @controller.design(:home, actions: [:index])
    expect(@controller.files[0][:content].include?('home/index')).to eql(true)
  end

end