# DEVLESS RAILS EXAMAPLE (THE WHOLE PROCESS)

## Step One
Create a rails app from your terminal and name it anything I will call mine "devless"
```
  $ rails new devless
```
Navigate into the folder from terminal and run bundle
```
$ bundle
```

## Step Two
Add The 'DV_RUBY_SDK' gem by going into your gem file and pasting this code
```Ruby
  gem 'DV_RUBY_SDK'
```

Go back to your console and run bundle install
```
$ bundle install
```

Create a controller with an action in my case I will create a controller called devless with an index action. This is how I will do it.

```
$ rails g controller devless index
```

## Step Three
#### Navigate to your config folder in the root and look for a folder called initializers. Create a file called devless.rb to configure devless. This the src config/initializers/devless.rb. You will need a token and a url to configure

##### You will see your {token} and the app {url} in the app section of the devless app you created on  hosted on heroku. Click on the app tab and on your left and  just scroll down on your right you will see the token copy it.
##### Url: Just copy the root of the devless app you created and hosted on heroku

In my case my token is "7740b4b2303e32957a3215c344b8c21c" and my url is "http://newerapper.herokuapp.com" so since i have these can configure.


#### Go to config/initializers/devless.rb and paste this code (Use your token and url not this)
```Ruby
  DVRUBYSDK.token = "7740b4b2303e32957a3215c344b8c21c"
  DVRUBYSDK.url   = "http://newerapper.herokuapp.com"
```

## Step Three
Navigate to app/controller and let's write some logic in the controller we created so we can post and query data on our devless backend. Copy and paste this code in the index action of your controller or you can also paste it in any action in your controller. Please read the comments to see what you have to do to customize it well.

```Ruby
  #create an instance of the devless class and assign it to a varibale.
  # I will call mine *@devless* but you could call yours anything.

  @devless = DVRUBYSDK::Devless.new

  #At this stage we can query data, post data, patch and do what ever we want to our table from here
  #Lets first query data
  service_name = "names"
  table_name = "eit_names"
  @query_response = @devless.query_data(service_name, table_name)

  #lets post data to that same table called "eit_names" which require one field ie "name"
  @data_we_want_to_post = {name: "Charles"}
  @post_data_response = devless.add_data(service_name, table_name, data_we_want_to_post)
```
## step Four
Access your data from the view or wherever you want to use it. So lets go to our view for the controller ie views/devless/index.html.erb in our case and paste this code and that is it!! Easy!
```Rails
  <%= @query_response %>
  <%= @post_data_response %>
```

This is It you can do whatever you want with it read more methods in the sdk documentation. It is super easy, fast and efficient. Tell your friends about devless.

## If you already have this just download this project and run bundle install on your local change the config/initializers/devless.rb and start using it. happy coding!!. Welcome to Devless
