require "../../spec_helper"

module Elasticsearch
  module Test
    class IndicesDeleteTemplateTest
      include Spec

      context "Indices: Delete Template: " do
        subject = Elasticsearch::Test::Client.new({:host => "localhost", :port => 9250})

        it "delete a template" do
          subject.indices.put_template({:name => "test", :body => {"order" => 0, 
                                                                   "version" => 1, 
                                                                   "template" => "test",
                                                                   "index_patterns" => "test-*",
                                                                   "settings" => {"number_of_shards" => "1", 
                                                                                  "number_of_replicas" => "0"}}})
          subject.indices.delete_template({:name => "test"})
          (subject.cat.templates.as(String).empty?).should be_true
        end
      end
    end
  end
end
