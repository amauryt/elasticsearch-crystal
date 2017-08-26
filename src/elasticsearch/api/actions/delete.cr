module Elasticsearch
  module API
    module Actions

      # Delete a single document.
      #
      # @example Delete a document
      #
      #     client.delete index: 'myindex', type: 'mytype', id: '1'
      #
      # @example Delete a document with specific routing
      #
      #     client.delete index: 'myindex', type: 'mytype', id: '1', routing: 'abc123'
      #
      # @option arguments [String] :id The document ID (*Required*)
      # @option arguments [Number,List] :ignore The list of HTTP errors to ignore; only `404` supported at the moment
      # @option arguments [String] :index The name of the index (*Required*)
      # @option arguments [String] :type The type of the document (*Required*)
      # @option arguments [String] :consistency Specific write consistency setting for the operation
      #                                         (options: one, quorum, all)
      # @option arguments [String] :parent ID of parent document
      # @option arguments [Boolean] :refresh Refresh the index after performing the operation
      # @option arguments [String] :replication Specific replication type (options: sync, async)
      # @option arguments [String] :routing Specific routing value
      # @option arguments [Time] :timeout Explicit operation timeout
      # @option arguments [Number] :version Explicit version number for concurrency control
      # @option arguments [String] :version_type Specific version type (options: internal, external, external_gte, force)
      #
      # @see http://elasticsearch.org/guide/reference/api/delete/
      #
      def delete(arguments={} of Symbol => String)
        if !arguments.has_key?(:index) || !arguments.has_key?(:type) || !arguments.has_key?(:id)
          raise ArgumentError.new("Required argument 'index' or 'type' or 'id' missing")
        end

        valid_params = [
          :consistency,
          :parent,
          :refresh,
          :replication,
          :routing,
          :timeout,
          :version,
          :version_type ]

        method = "DELETE"
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
