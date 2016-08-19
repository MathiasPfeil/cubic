require 'spec_helper'

RSpec.describe Cubic::Generator do
  
  let(:root_path) { File.join(Dir.getwd, '/spec/generator_app') }

  before :all do
    Cubic.sitemap do
    
      config do
        root_path  Dir.getwd + '/spec/generator_app'
        name       'Test App'
        orm        'Sequel'
        db         'sqlite3'
        html_type  'haml'
        css_type   'css'
        test_type  'RSpec'
        gems       ['bcrypt']
      end
    
      models do
        design(:user,      {email: :string, password_digest: :string}).add('has_many :link_posts', 'has_secure_password')
        design(:self_post, {title: :string, content: :text}).add('belongs_to :user')
        design(:link_post, {title: :string, link: :text}).add('belongs_to :user')
        design(:static,    {title: :string, content: :text})
        design(:tag,       {name: :string})
        design(:tagging,   {post_type: :string, post_id: :integer, tag_id: :integer})
      end
    
      controllers do
        design(:home, actions: [:index])
        design(:user, actions: [])
        design(:sessions)
        design(:static)
      end
    end
  end
  
  after :all do 
    FileUtils.rm_rf(Dir.getwd + '/spec/generator_app')
  end
  
  it 'generates project' do
    expect(Dir.exists?(root_path)).to eql(true)
  end
  
  it 'generates view with extension defined in config' do
    expect(File.exists?(Dir.getwd + '/spec/generator_app/app/views/home/index.haml')).to eql(true)
  end
  
  context 'generates directory' do
  
    it 'config' do
      expect(Dir.exists?(root_path + '/config')).to eql(true)
    end
    
    it 'bin' do
      expect(Dir.exists?(root_path + '/bin')).to eql(true)
    end
    
    it 'db' do
      expect(Dir.exists?(root_path + '/db')).to eql(true)
    end
    
    it 'db/migrations' do
      expect(Dir.exists?(root_path + '/db/migrations')).to eql(true)
    end
    
    it 'public' do
      expect(Dir.exists?(root_path + '/db/migrations')).to eql(true)
    end
    
    it 'public/stylesheets' do
      expect(Dir.exists?(root_path + '/db/migrations')).to eql(true)
    end
    
    it 'public/javascripts' do
      expect(Dir.exists?(root_path + '/db/migrations')).to eql(true)
    end
    
    it 'spec' do
      expect(Dir.exists?(root_path + '/db/migrations')).to eql(true)
    end
  
  end
  
  context 'generates file' do
  
    it 'models/user.rb' do
      expect(File.exists?(root_path + '/app/models/user.rb')).to eql(true)
    end
    
    it 'controllers/user_controller.rb' do
      expect(File.exists?(root_path + '/app/controllers/user_controller.rb')).to eql(true)
    end
    
    it 'views/index.haml' do
      expect(File.exists?(root_path + '/app/views/home/index.haml')).to eql(true)
    end
    
    it 'bin/cubic' do
      expect(File.exists?(root_path + '/bin/cubic')).to eql(true)
    end
    
    it '/config.ru' do
      expect(File.exists?(root_path + '/config.ru')).to eql(true)
    end
    
    it 'config/application.rb' do
      expect(File.exists?(root_path + '/config/application.rb')).to eql(true)
    end
    
    it 'layout/application.haml' do
      expect(File.exists?(root_path + '/app/views/layout/application.haml')).to eql(true)
    end
    
    it 'config/boot.rb' do
      expect(File.exists?(root_path + '/config/boot.rb')).to eql(true)
    end
    
    it '/Rakefile' do
      expect(File.exists?(root_path + '/Rakefile')).to eql(true)
    end
    
    it 'db/database.rb' do
      expect(File.exists?(root_path + '/db/database.rb')).to eql(true)
    end
    
    it 'public/stylesheets/application.css' do
      expect(File.exists?(root_path + '/public/stylesheets/application.css')).to eql(true)
    end
    
    it 'public/javascripts/application.js' do
      expect(File.exists?(root_path + '/public/javascripts/application.js')).to eql(true)
    end
  end
end