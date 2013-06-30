require 'cloud_builder'
require 'rubygems'
require 'aws-sdk'

stack = CloudBuilder::Stack.new(File.expand_path('../../stacks/example.rb', __FILE__))

describe stack, "#valid_cfn" do 
	it "returns valid cloudformation" do
		cf = AWS::CloudFormation.new
    template = stack.to_json
    result = cf.validate_template(template)
    result.has_key?(:code).should eq false
  end
end