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


#lets post data to that same table called "eit_names" which require one filed ie "name"
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
