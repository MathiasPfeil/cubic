# Cubic
[![Build Status](https://travis-ci.org/Scootin/cubic.svg?branch=master)](https://travis-ci.org/Scootin/cubic)
[![Coverage Status](https://coveralls.io/repos/github/Scootin/cubic/badge.svg?branch=master)](https://coveralls.io/github/Scootin/cubic?branch=master)

Cubic is a small framework built with a focus on quickly creating applications through a neat, easily readable file that defines the basic structure of your app.

## Sitemap (Generator)
Cubic expects an application to be generated using a 'sitemap.rb' file. In general, you will place this file in the directory you would like to generate your application inside of, but you can also tell Cubic to generate your application in a directory other than the one your sitemap currently resides in.
Within the sitemap.rb file, you will design a basic structure for your application,
then run that file with `ruby sitemap.rb` to generate it.

Here is an example of how such a file might look.

```ruby
require 'cubic'

Cubic.sitemap do

  config do
    root_path  File.expand_path('../', __FILE__)
    html_type  'haml'
    css_type   'css'
  end

  models do 
    design(:user, {email: :string, password_digest: :string}).add('# comment')
    design(:post, {title: :string, content: :string})
  end

  controllers do
    design(:home, actions: [:index])
    design(:user, actions: [:new])
    design(:session, actions: [:new])
    design(:post, actions: [:new, :show, :edit])
  end
end
```

Let's quickly run through the blocks within the sitemap file.

### Config
```ruby
root_path  File.expand_path('../', __FILE__)
```  
The root_path option tells the generator where you would like the application to be generated.
```ruby
html_type  'haml'
css_type   'css'
```  
html_type and css_type tell the generator what template engine and preprocessor language you would files to be generated with.

### Models
The models block does exactly what you think; it generates your models!
```ruby
design(:post, {title: :string, content: :string})
```  
The first argument passed to the design
method tells the generator what you would like to name your model. The next argument, a hash,
is what will be passed to the migrations generator to create a database table for your model.

You can call `add()` on the design method to add code directly into the model to be generated.
Every argument is a new line, so something like:
```ruby
add('one_to_many :authorships', 'many_to_many :books')
```
generates the following

```ruby
class SomeModel < Sequel::Model
one_to_many :authorships
many_to_many :books

end
```

### Controllers
```ruby
design(:post, actions: [:new, :show, :edit])
```  
Generating a controller is similar to model. The first argument given is the name of the controller,
then you add your actions. The array associated with the action key is what will be used to create the necessary
views for your controller, but also the routes held within the controller. If that is kind of confusing,
the routing section below will explain. 

That is about as deep as the generator goes for now, so lets move on.

## Defining routes
In a Cubic application, you define your routes within the controllers you have generated. You will notice each 
controller has a namespace block, which all of your routes are defined within. It's okay
to create a route outside of this block, but to keep things easy to find, all routes are created within it by default.

Below you can see an example of a normal Cubic controller. All HTTP methods you see defined within the
namespace block are the ones given to you at the moment.

```ruby 
class HomeController < Cubic::CubicController
  namespace 'home' do

    get 'index' do
    end
    
    post 'index' do
    end
    
    put 'index' do
    end
    
    destroy 'index' do
    end
  end
end
```

Your route can have variables, which will be translated into a params hash.

```ruby 
get 'post/:title' do

end
```

Then you could get the value passed in the url from within the controller or view
using the following:

```ruby 
params[:title]
```
You can use regular expressions as well.
```ruby 
get /hello\/regex/ do
end
```

## ORM
Cubic uses Sequel as its ORM. To learn more about Sequel, read the documentation here: https://github.com/jeremyevans/sequel

## Differences Between Environments
As of now, Cubic's only major difference between Development and Production is the reloading of controller actions.
Because controller actions in Cubic are also routes, they must reloaded everytime a new call is made, which also means
any changes you make to a route also resets.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
