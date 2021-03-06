require "../../spec_helper"

module Elasticsearch
  module Test
    class SnapshotStatusTest
      include Spec

      context "Snapshot: Status : " do
        subject = Elasticsearch::Test::Client.new({:host => "localhost", :port => 9250})

        Spec.after_each do
          subject.snapshot.delete_repository({:repository => "test_cat_repo_1"})
        end

        it "Status of snapshot" do
          subject.snapshot.create_repository({:repository => "test_cat_repo_1", :body => {"type" => "fs",
                                                                                          "settings" => {"location" => "test_cat_repo_1_loc"}}})
          subject.snapshot.create({:repository => "test_cat_repo_1", :snapshot => "snap1", :wait_for_completion => true})
          subject.snapshot.status({:repository => "test_cat_repo_1", :snapshot => "snap1"})
        end
      end
    end
  end
end
