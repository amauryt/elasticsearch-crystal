module Elasticsearch
  module API
    module Actions

      # Retrieve an indexed template from Elasticsearch
      #
      # @option arguments [String] :id Template ID
      #
      # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/search-template.html
      #
      def delete_template(arguments={} of Symbol => String)
        method = HTTP_DELETE
        path   = "_search/template/#{arguments[:id]}"
        params = {} of String => String
        body   = nil

        perform_request(method, path, params, body).body
      end
    end
  end
end
