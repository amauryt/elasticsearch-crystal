module Elasticsearch
  module API
    module Actions

      # Return a specified document's `_source`.
      #
      # The response contains just the original document, as passed to Elasticsearch during indexing.
      #
      # @example Get a document `_source`
      #
      #     client.get_source index: 'myindex', type: 'mytype', id: '1'
      #
      # @option arguments [String] :id The document ID (*Required*)
      # @option arguments [Number,List] :ignore The list of HTTP errors to ignore; only `404` supported at the moment
      # @option arguments [String] :index The name of the index (*Required*)
      # @option arguments [String] :type The type of the document; use `_all` to fetch the first document
      #                                  matching the ID across all types) (*Required*)
      # @option arguments [List] :fields A comma-separated list of fields to return in the response
      # @option arguments [String] :parent The ID of the parent document
      # @option arguments [String] :preference Specify the node or shard the operation should be performed on
      #                                        (default: random)
      # @option arguments [Boolean] :realtime Specify whether to perform the operation in realtime or search mode
      # @option arguments [Boolean] :refresh Refresh the shard containing the document before performing the operation
      # @option arguments [String] :routing Specific routing value
      # @option arguments [String] :_source Specify whether the _source field should be returned,
      #                                     or a list of fields to return
      # @option arguments [String] :_source_exclude A list of fields to exclude from the returned _source field
      # @option arguments [String] :_source_include A list of fields to extract and return from the _source field
      #
      # @see http://elasticsearch.org/guide/reference/api/get/
      #
      # @since 0.90.1
      #
      def get_source(arguments={} of Symbol => String)
        if !arguments.has_key?(:id) || !arguments.has_key?(:index) || !arguments.has_key?(:id)
          raise ArgumentError.new("Required argument 'id' or 'index' or 'id' missing")
        end
        arguments[:type] ||= "_all"

        valid_params = [
          :fields,
          :parent,
          :preference,
          :realtime,
          :refresh,
          :routing,
          :_source,
          :_source_include,
          :_source_exclude ]

        method = "GET"
        path   = Utils.__pathify Utils.__escape(arguments[:index].as(String)),
                                 Utils.__escape(arguments[:type].as(String)),
                                 Utils.__escape(arguments[:id].as(String)),
                                 "_source"

        params = Utils.__validate_and_extract_params arguments, valid_params
        body   = nil

        perform_request(method, path, params, body).body

      end
    end
  end
end
