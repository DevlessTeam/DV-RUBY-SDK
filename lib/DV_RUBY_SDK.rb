require 'DV_RUBY_SDK/version'
require 'uri'
require 'net/http'
require 'json'

module DVRUBYSDK

  $token = nil
  $url = nil
  $port = nil
  $devless_user_token = nil

  def self.token=(token); $token = token; end
  def self.url=(url); $url = url; end
  def self.port=(port); $port = port; end
  def self.set_user_token=(dv_user_token); $devless_user_token = dv_user_token; end

  class Devless

    def initialize
      @parameters = Hash.new{|hsh,key| hsh[key] = [] }
    end

    def method_call(service, method, params)
      base_url = "#{$url}:#{$port}/api/v1/service/#{service}/rpc?action=#{method}"
      get_id = rand(2000*1233)
      payload = {:jsonrpc => "2.0", :method => service, :id => get_id, :params => params}

      return request_processor(base_url, "Post", payload)
    end

    def add_data(service, table, data)
      base_url = "#{$url}:#{$port}/api/v1/service/#{service}/db"
      payload = {:resource => [{:name => table, :field => [data]}]}

      return request_processor(base_url, "Post", payload)
    end

    def update_data(service, table, data)
      base_url = "#{$url}:#{$port}/api/v1/service/#{service}/db"
      payload = {:resource => [{:name => table, :params => [{:where => "#{@parameters[:where]}", :data => [data]}]}]}

      return request_processor(base_url, "Patch", payload)
    end

    def delete_data(service, table)
      base_url = "#{$url}:#{$port}/api/v1/service/#{service}/db"
      payload = {:resource => [{:name => table, :params => [{:delete => true, :where => "#{@parameters[:where]}"}]}]}

      return request_processor(base_url, "Delete", payload)
    end

    def query_data(service, table)

      if @parameters.size != 0
        params = nil

        if @parameters.key?(:where)
          @parameters[:where].each do |value|
            params ="&where=#{value}#{params}"
          end
          @parameters.delete :where
        end

          @parameters.each do |key, value|
            params = "&#{key}=#{value}#{params}"
          end

        base_url = "#{$url}:#{$port}/api/v1/service/#{service}/db?table=#{table}#{params}"
      else
        base_url = "#{$url}:#{$port}/api/v1/service/#{service}/db?table=#{table}"
      end

      return request_processor(base_url, "Get")
    end

    def search(service, table, column_to_search, text_to_search)
      params = "&search=#{column_to_search},#{text_to_search}"
      base_url = "#{$url}:#{$port}/api/v1/service/#{service}/db?table=#{table}#{params}"

      return request_processor(base_url, "Get")
    end

    def size(value)
      @parameters[:size] = value
      self
    end

    def where(key, value)
      @parameters[:where].push "#{key},#{value}"
      self
    end

    def order_by(value)
      @parameters[:orderBy] = value
      self
    end

    def offset(value)
      @parameters[:offset] = value
      self
    end

    private

    def request_processor(url, option, payload=nil)
      @parameters = {}
      path = URI(url)

      http = Net::HTTP.new(path.host, path.port)

      request = case option
      when "Get"    then Net::HTTP::Get.new(path)
      when "Post"   then Net::HTTP::Post.new(path)
      when "Patch"  then Net::HTTP::Patch.new(path)
      when "Delete" then Net::HTTP::Delete.new(path)
      end

      request["devless-token"] = $token
      request["content-type"] = 'application/json'
      request["devless-user-token"] = $devless_user_token ? $devless_user_token : nil

      request.body = payload.to_json if option == "Post" || option == "Patch" ||option == "Delete"
      response = http.request request
      return response.read_body.to_json
    end

  end

end
