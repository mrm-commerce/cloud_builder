require 'clamp'
require 'aws-sdk'

require 'tempfile'

module CloudBuilder
  class StackCommand < Clamp::Command
    parameter "STACK", "stack to build"
    option ["-r", "--region"], "REGION", "AWS region to use", :default => "us-east-1", :environment_variable => "AWS_DEFAULT_REGION"
    option ["-v", "--validate"], :flag, "validate the stack file before doing anything else"
    option ["-b", "--bucket"], "BUCKET", "upload template to BUCKET", :attribute_name => :bucket, :default => nil, :environment_variable => "CLOUD_BUILDER_BUCKET"
    option ["-t", "--diff-tool"], "DIFF_TOOL", "tool to use for diff", :environment_variable => "CLOUD_BUILDER_DIFF_TOOL"
    option ["-c", "--create"], :flag, "create the stack"
    option ["-u", "--update"], :flag, "update the stack"

    option ["-d", "--diff"], :flag, "do a diff between the existing template in BUCKET and the generated template"

    option ["-e", "--estimate"], :flag, "estimate template cost"
    option ["-m", "--dummy"], :flag, "add a dummy WaitConditionHandle to the template"

    def execute
      template = CloudBuilder::Stack.new(stack)
      
      if dummy?
        template.resource "dummy" do 
          type "AWS::CloudFormation::WaitConditionHandle"
        end
      end
      
      template = template.to_json + "\n"

      cf = AWS::CloudFormation.new(:cloud_formation_endpoint => 'cloudformation.%s.amazonaws.com' % region)

      s3 = AWS::S3.new

      key = File.basename(stack, '.*')

      if validate?
        result = cf.validate_template(template)
        if result.has_key?(:code)
          raise Exception, "Could not validate!\ncode=#{result[:code]}\nreason=#{result[:reason]}\n"
        end
      end

      if diff?
        remote_template = cf.stacks[key].template
        
        # b = s3.buckets[bucket]
        # o = b.objects[key]
        # remote_template = o.read
        
        t1 = Tempfile.new('stack')
        t1.write(remote_template)
        t1.close

        t2 = Tempfile.new('stack')
        t2.write(template)
        t2.close

        cmd = "%s %s %s" % [diff_tool ? diff_tool : "git diff --color", t1.path, t2.path]
        # puts cmd
        puts `#{cmd}`
        return
      end

      if bucket
        b = s3.buckets[bucket]
        o = b.objects[key]
        o.write template
        template = o.public_url
      else
        puts template
      end

      if estimate?
        puts cf.estimate_template_cost(template, :capabilities => ["CAPABILITY_IAM"] )
        return
      end

      if create?
        cf.stacks.create(key, template, :capabilities => ["CAPABILITY_IAM"] )
      elsif update?
        cf.stacks[key].update(:template => template, :capabilities => ["CAPABILITY_IAM"])
      end

    end
  end
end