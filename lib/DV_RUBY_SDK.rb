require "DV_RUBY_SDK/version"
require 'uri'
require 'net/http'
require 'json'

module DVRUBYSDK
  class SDK

    @token = nil
    @url = nil
    @port = nil
    @devless_user_token = nil

    def self.token=(token); @token = token; end
    def self.url=(url); @url = url; end
    def self.port=(port); @port = port; end
    def self.set_user_token=(dv_user_token); @devless_user_token = dv_user_token; end

    def request_processor(url, option, payload=nil)
      path = URI(url)

      http = Net::HTTP.new(path.host, path.port)

      request = case option
      when "Get"    then Net::HTTP::Get.new(path)
      when "Post"   then Net::HTTP::Post.new(path)
      when "Patch"  then Net::HTTP::Patch.new(path)
      when "Delete" then Net::HTTP::Delete.new(path)
      end

      request["devless-token"] = @token
      request["content-type"] = 'application/json'
      request["devless-user-token"] = @devless_user_token ? @devless_user_token : nil

      request.body = payload.to_json if option == "Post" || option == "Patch" ||option == "Delete"
      response = http.request request
      return response.read_body
    end

    def method_call(service, method, params)
      base_url = "#{@url}:#{@port}/api/v1/service/#{service}/rpc?action=#{method}"
      get_id = rand(2000*1233)
      payload = {:jsonrpc => "2.0", :method => service, :id => get_id, :params => params}

      return self.request_processor(base_url, "Post", payload)
    end

    def self.query_data(service, table, params={})
      parameters = nil
      if params.size != 0
        params.each { |k,v| parameters = "&#{k}=#{v}#{parameters}" }
        base_url = "#{@url}:#{@port}/api/v1/service/#{service}/db?table=#{table}#{parameters}"
      else
        base_url = "#{@url}:#{@port}/api/v1/service/#{service}/db?table=#{table}"
      end
      return self.request_processor(base_url, "Get")
    end

    def self.add_data(service, table, data)
      base_url = "#{@url}:#{@port}/api/v1/service/#{service}/db"
      payload = {:resource => [{:name => table, :field => [data]}]}

      return self.request_processor(base_url, "Post", payload)
    end

    def self.update_data(service, table, key, value, data)
      base_url = "#{@url}:#{@port}/api/v1/service/#{service}/db"
      payload = {:resource => [{:name => table, :params => [{:where => "#{key},#{value}", :data => [data]}]}]}

      return self.request_processor(base_url, "Patch", payload)
    end

    def self.delete_data(service, table, key, value)
      base_url = "#{@url}:#{@port}/api/v1/service/#{service}/db"
      payload = {:resource => [{:name => table, :params => [{:delete => true, :where => "#{key},=,#{value}"}]}]}

      return self.request_processor(base_url, "Delete", payload)
    end
    
  end

end
