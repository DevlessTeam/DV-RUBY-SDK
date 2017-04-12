class DevlessController < ApplicationController
  def index
    #create an intance of the devless class and assign it to a varibale.
    # I will call mine *@devless* you could call yours anything.

    @devless = DVRUBYSDK::Devless.new

    #at this stage we can query data, post data, patch and do what ever we want to our table from here
    #lets first query data
    service_name = "names"
    table_name = "eit_names"
    @query_response = @devless.query_data(service_name, table_name)

    #lets post data to that same table called "eit_names" which require one field ie "name"
    @data_we_want_to_post = {name: "Charles"}
    @post_data_response = devless.add_data(service_name, table_name, data_we_want_to_post)

  end
end
