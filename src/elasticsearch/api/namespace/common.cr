require "http/client"
require "json"

module Elasticsearch
  module API
    module Common
      module Actions; end

      module Constants
        DEFAULT_SERIALIZER = JSON

        COMMON_PARAMS = [
          :ignore,                        # Client specific parameters
          :index, :type, :id,             # :index/:type/:id
          :body,                          # Request body
          :node_id,                       # Cluster
          :name,                          # Alias, template, settings, warmer, ...
          :field                          # Get field mapping
        ]

        COMMON_QUERY_PARAMS = [
          :ignore,                        # Client specific parameters
          :format,                        # Search, Cat, ...
          :pretty,                        # Pretty-print the response
          :human,                         # Return numeric values in human readable format
          :filter_path                    # Filter the JSON response
        ]

        HTTP_GET          = "GET"
        HTTP_HEAD         = "HEAD"
        HTTP_POST         = "POST"
        HTTP_PUT          = "PUT"
        HTTP_DELETE       = "DELETE"
        UNDERSCORE_SEARCH = "_search"
        UNDERSCORE_ALL    = "_all"
      end

      class Response
        getter :status, :body, :headers
        def initialize(@status : Int32, @body : String, @headers : HTTP::Headers)
        end
      end

      class JsonResponse
        getter :status, :body, :headers
        def initialize(@status : Int32, @body : JSON::Any, @headers : HTTP::Headers)
        end
      end

      class Client
        def initialize(@settings : Hash(Symbol, String | Int32))
        end

        def perform_request(method, path, params={} of String => String, body={} of String => String | Nil, headers = HTTP::Headers{"Content-Type" => "application/json"})

          # normalize params to string
          new_params = {} of String => String
          params.each do |k,v|
            if !!v == v
              new_params[k.to_s] = ""
            else
              new_params[k.to_s] = v.to_s
            end
          end

          final_params = HTTP::Params.encode(new_params)

          if !body.nil?
            post_data = body.to_json
          else
            post_data = nil
          end

          base_url = "http://#{@settings[:host]}:#{@settings[:port]}/#{path}"

          response = case method
                      when "GET"
                        HTTP::Client.get("#{base_url}?#{final_params}", body: post_data, headers: headers)
                      when "POST"
                        HTTP::Client.post(url: base_url, body: post_data, headers: headers)
                      when "PUT"
                        HTTP::Client.put(url: base_url, body: post_data, headers: headers)
                      when "DELETE"
                        HTTP::Client.delete(url: "#{base_url}?#{final_params}")
                      when "HEAD"
                        HTTP::Client.head(url: base_url)
                      end

          result = response.as(HTTP::Client::Response)

          if result.headers["Content-Type"].includes?("application/json") && method != "HEAD"
            final_response = JsonResponse.new result.status_code, JSON.parse(result.body), result.headers
          else
            final_response = Response.new result.status_code, result.body.as(String), result.headers
          end

          final_response

        end
      end
    end
  end
end
