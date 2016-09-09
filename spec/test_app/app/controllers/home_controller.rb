class HomeController < Cubic::CubicController
  
  namespace('home') do
    
    get 'login' do
      haml 'home/login'
    end
    
  end
  
  get '/index' do
    haml 'home/index'
  end
  
  put '/index' do
  end
  
  delete '/index' do
  end
  
  get '/html' do
    html 'home/test'
  end
  
  get '/erb' do
    erb 'home/show'
  end

  get /regex\/hello/ do
    erb 'home/show'
  end

  get 'logout/:id' do
    haml 'home/index'
  end
  
  post '/cannot_get' do
  end
  
  get '/pass/:text' do
    @text = params[:text]
    haml 'home/pass'
  end
  
  get '/model/methods' do
    @text = LinkPost.greeting
    haml 'home/pass'
  end
  
  get '/test/instance_variables' do
    @text = 'instance_variable'
    haml 'home/pass'
  end
  
  get '/user/add_one_to_id/:id' do
    @text = "id: #{params[:id] + 1}"
    haml 'home/pass'
  end
  
  get '/render/json' do
    json({'mimic' => 'database_record'})
  end
  
  get '/redirect_to_index' do
    redirect('/index')
  end
  
  get '/test/render' do
    render('haml', 'home/pass')
  end
  
  get '/log/:log' do
    log(params[:log])
    haml 'home/index'
  end

end