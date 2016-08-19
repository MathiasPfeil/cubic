RSpec.describe Cubic::Generator::Model do
  
  before :each do
    @model = Cubic::Generator::Model.new
  end
  
  it 'creates record to be generated' do
    @model.design(:user, {name: :string})
    expect(@model.files.size).to eql(1)
  end
  
  it 'allows user to add code to model' do
    @model.design(:user, {name: :string}).add('has_many :posts')
    expect(@model.files[0][:content].include?('has_many :posts')).to eql(true)
  end
  
  it 'allows user to add code to model' do
    Cubic::Generator::Config.orm('TestString')
    model = @model.design(:user, {name: :string}).add('has_many :posts')
    expect(model.include?('TestString')).to eql(true)
  end
  
end
