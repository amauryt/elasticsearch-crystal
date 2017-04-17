require "../../spec_helper"

module Elasticsearch
  module Test
    class IndicesCreateTest
      include Spec

      context "Indices: Create" do
        subject = Elasticsearch::Test::Client.new({:host => "localhost", :port => 9250})

        Spec.after_each do
          #subject.indices.delete({:index => "test_index"})
        end

        it "should create an index with mappings" do
          subject.indices.create({:index => "test_index", :body => {"mappings" => {"type_1" => {} of String => String}}})
          subject.indices.get_mapping({:index => "test_index"}).to_json.should match /(?=.*mappings)(?=.*type_1)(?=.*test_index)/
        end

        it "should create an index with settings" do 
          subject.indices.create({:index => "test_index", :body => {"settings" => {"number_of_replicas" => "0"}}})
          subject.indices.get_settings({:index => "test_index"}).to_json.should match /(?=.*settings)(?=.*0)(?=.*test_index)(?=.*replicas)/
        end
      end
    end
  end
end
