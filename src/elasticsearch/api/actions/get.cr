module Elasticsearch
  module API
    module Actions

      # Return a specified document.
      #
      # The response contains full document, as stored in Elasticsearch, incl. `_source`, `_version`, etc.
      #
      # @example Get a document
      #
      #     client.get index: 'myindex', type: 'mytype', id: '1'
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
      # @option arguments [Number] :version Explicit version number for concurrency control
      # @option arguments [String] :version_type Specific version type (options: internal, external, external_gte, force)
      # @option arguments [String] :_source Specify whether the _source field should be returned,
      #                                     or a list of fields to return
      # @option arguments [String] :_source_exclude A list of fields to exclude from the returned _source field
      # @option arguments [String] :_source_include A list of fields to extract and return from the _source field
      # @option arguments [Boolean] :_source_transform Retransform the source before returning it
      # @option arguments [List] :stored_fields A comma-separated list of stored fields to return in the response
      #
      # @see http://elasticsearch.org/guide/reference/api/get/
      #
      def get(arguments={} of Symbol => String)
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
          :version,
          :version_type,
          :_source,
          :_source_include,
          :_source_exclude,
          :_source_transform,
          :stored_fields ]

        method = "GET"
        path   = Utils.__pathify Utils.__escape(arguments[:index].as(String)),
                                 Utils.__escape(arguments[:type].as(String)),
                                 Utils.__escape(arguments[:id].as(String))

        params = Utils.__validate_and_extract_params arguments, valid_params
        body   = nil

        perform_request(method, path, params, body).body

      end
    end
  end
end
