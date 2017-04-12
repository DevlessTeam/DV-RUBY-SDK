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

# Setup your Devless credentials
If you are using rails you may create a new file called devless.rb in the config/initializers folder and begn the set up.

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
# Create an instance of the Devless class to have access to the methods

```ruby
@devless = DVRUBYSDK::Devless.new
```
# To add data to table

```ruby
data = {:name => "Tsatsu"}
results = @devless.add_data("service_name", "service_table", data)
puts results
```

# To query data from table

```ruby
results = @devless.query_data("service_name", "service_table")
puts results
```

# Also you may filter your query with:

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

# To update data in table

```ruby
data = {:name => "Edwin"}
results = @devless.where("id", 1).update_data("service_name", "service_table", data)
puts results
```

# To delete data from table

```ruby
results = @devless.where("id", 1).delete_data("service_name", "service_table")
puts results
```

# Make a call to an Action Class in the Devless instance

```ruby
results = @devless.method_call("service_name", "method_name", {})
puts results
```

# Authenticating with a Devless instance

```ruby
user_token = @devless.method_call("dvauth", "login", {:email => "k@gmail.com", :password => "password"});
user_token = JSON.parse(user_token)
@devless.set_user_token(user_token);
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DevlessTeam/DV_RUBY_SDK. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
