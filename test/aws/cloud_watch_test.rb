require 'test_helper'
require 'aws/cloud_watch'

describe AWS::CloudWatch do

  before do
    @api = AWS::CloudWatch.new "key", "secret"
  end

  it "points to endpoint, default to us-east-1" do
    @api.uri.must_equal "https://monitoring.us-east-1.amazonaws.com"
  end

  it "works with the current version" do
    @api.version.must_equal "2010-08-01"
  end

  describe "API calls" do

    it "builds and signs calls with ActionParam rules" do
      AWS::Connection.any_instance.expects(:call).with do |request|
        params = request.params
        params.wont_be_nil

        params["Action"].must_equal "ListMetrics"
        params["Signature"].wont_be_nil

        true
      end

      obj = AWS::CloudWatch.new "key", "secret"
      obj.list_metrics
    end

  end
end
