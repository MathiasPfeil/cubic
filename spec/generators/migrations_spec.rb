RSpec.describe Cubic::Generator::Migrations do
  
  before :each do
    @migration = Cubic::Generator::Migrations.new
  end
  
  it 'creates record to be generated' do
    @migration.design(:user, {name: :string})
    expect(@migration.files.size).to eql(1)
  end
end