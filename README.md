# DVRUBYSDK

Official Devless Ruby SDK

## Official Documentation

Refer to https://docs.devless.io for a detailed documentation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'DV_RUBY_SDK'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install DV_RUBY_SDK

## Usage

### Setup your DevLess credentials
If you are using rails you may create a new file called devless.rb in the config/initializers folder and set it up with your credentials this way

```ruby
DVRUBYSDK.token = "52babb518f716ea9014baeb42926b9f9"
DVRUBYSDK.url = "http://myapp.herokuapp.com"
```

For  a normal Ruby script just follow this procedure

```ruby
require "DV_RUBY_SDK"
DVRUBYSDK.token = "52babb518f716ea9014baeb42926b9f9"
DVRUBYSDK.url = "http://myapp.herokuapp.com"
```
### Create an instance of the DevLess class to have access to the methods

```ruby
@devless = DVRUBYSDK::Devless.new
```
### To add data to table

```ruby
data = {:name => "Tsatsu"}
results = @devless.add_data("service_name", "service_table", data)
puts results
```

### To query data from table

```ruby
results = @devless.query_data("service_name", "service_table")
puts results
```

### Also you may filter your query with:

``size:`` determine the number of results to return

```ruby
results = @devless.size(3).query_data("service_name", "service_table")
puts results
```

``offset:`` Set step in data data to be sent back
*NB: This is to be used in combination with size*

```ruby
results = @devless.offset(2).size(6).query_data("service_name", "service_table")
puts results
```

``where:`` Get data based where a key matches a certain value

```ruby
results = @devless.where("name", "Tsatsu").query_data("service_name", "service_table")
puts results
```

``order_by:`` Order incoming results in descending order based on a key

```ruby
results = @devless.orderBy("name").query_data("service_name", "service_table")
puts results
```

### To update data in table

```ruby
data = {:name => "Edwin"}
results = @devless.where("id", 1).update_data("service_name", "service_table", data)
puts results
```

### To delete data from table

```ruby
results = @devless.where("id", 1).delete_data("service_name", "service_table")
puts results
```

### Make a call to an Action Class in the DevLess instance

```ruby
results = @devless.method_call("service_name", "method_name", {})
puts results
```

### Authentication! DevLess comes with authentication baked in. You can access the authentication methods using the DevLess SDK
#### NB: The five methods below require a user token to be set on the header for successful communicatiion with the DevLess backend😎

#### Sign In

```ruby
results = @devless.method_call("devless", "login", {:email => "k@gmail.com", :password => "password"})
user_token = JSON.parse(results)['payload']['result']['token']
@devless.set_user_token(user_token);
```
Options available are 'username', 'email' & 'phone_number'.

#### Sign Up
```ruby
results = @devless.method_call("devless", "signUp", {
  :email        => "k@gmail.com", 
  :password     => "password", 
  :username     => "ironman",
  :phone_number => "+233245632353",
  :first_name   => "Tony",
  :last_name    => "Stark",
})
user_token = JSON.parse(results)['payload']['result']['token']
@devless.set_user_token(user_token);
```
Options available to set the status & role of accounts.

#### Updating Profile
```ruby
results = @devless.method_call("devless", "updateProfile", {
  :email        => "avenger@gmail.com", 
  :password     => "dontangryme", 
  :username     => "hulk",
  :phone_number => "+233204432432",
  :first_name   => "Bruce",
  :last_name    => "Banner",
})
puts results
```

#### Retrieving Profile
```ruby
results = @devless.method_call("devless", "profile", {})
puts results
```

#### Log Out
```ruby
results = @devless.method_call("devless", "logout", {})
puts results
```

## Full Rails Example
### DEVLESS RAILS EXAMPLE (THE WHOLE PROCESS)

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

## Step Four
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
## Step Five
Access your data from the view or wherever you want to use it. So lets go to our view for the controller ie views/devless/index.html.erb in our case and paste this code and that is it!! Easy!
```Rails
  <%= @query_response %>
  <%= @post_data_response %>
```

This is It you can do whatever you want with it read more methods in the sdk documentation. It is super easy, fast and efficient. Tell your friends about devless.

 If you already have this just download this project from the eamples folder and run bundle install on your local change the config/initializers/devless.rb and start using it. happy coding!!. Welcome to Devless


## Full ruby example
  ```Ruby
  =begin
  step One Run gem install DV_RUBY_SDK
  step two create a .rb file and call it anything. I have called mine devless.rb in this instance

  Agenda
  -------

  We want to do a simple post and query from one of the tables in my service on my devless
  panel(the one I am hosting on heroku)
  The service name is called "names" and under this service I have a table called eit_names
  with one field called "name" which is a string

  service name = "names"
  table_name = "eit_names"
  let's do this!
  =end

  #require the gem
  require "DV_RUBY_SDK"

  =begin
  set it up with your credentials. you will need these two credentials {token}
  token can be found in the app tab on your devless panel where you created your services
  copy the token.
  my token  = "7740b4b2303e32957a3215c344b8c21c"
  You will also need the {url} ie the url of the devless app you created
  (in my case the one I created and hosted on heroku)
  my_app_url = "http://newerapper.herokuapp.com"
  If you have these two you can set up
  set it up this way
  =end

  my_token = "7740b4b2303e32957a3215c344b8c21c"
  my_app_url =  "http://newerapper.herokuapp.com"

  DVRUBYSDK.token = my_token
  DVRUBYSDK.url   = my_app_url

  #create an intance of the devless class and assign it to a varibale.
  # I will call mine *devless* you could call yours anything.

  devless = DVRUBYSDK::Devless.new

  #at this stage we can query data, post data, patch and do what ever we want to our table from here
  #lets first query data

  service_name = "names"
  table_name = "eit_names"

  query_response = devless.query_data(service_name, table_name)
  puts query_response


  #lets post data to that same table called "eit_names" which require one field ie "name"
  data_we_want_to_post = {name: "Charles"}
  post_data_response = devless.add_data(service_name, table_name, data_we_want_to_post)
  puts post_data_response

  =begin
  Run it by pressing command b on your sublime if youre on a mac or run the script in your terminal if otherwise.
  You should see data returned without any errors and when you check back in your table
  you will see a new entry in your database.
  Thats how fast, poowerful; and easy devless has made things
  Tell your friends about devless. Thanks
  =end

  ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DevlessTeam/DV_RUBY_SDK. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
