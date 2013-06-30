require 'rubygems'
require 'netaddr'

#
# Define some global variables
#

# This variable isn't used anywhere, but provides the perfect example for
# using Ruby code in the DSL 
globals.subnet_class_b = NetAddr::CIDR.create('10.200.0.0/16')

# 
globals.client = 'example'
globals.project = 'cloud_builder'
globals.environment = 'testing'

#
# We will not be using a vpc;
#
globals.no_vpc = true

#
# Include bricks
#
include_brick :example_tags
include_brick :example_security_groups

include_brick "mappings/ami_ids_ubuntu_ebs_20130624"
include_brick "mappings/instance2arch"

#
# Begin the actual template descriptions
#
description       "%s/%s/%s" % [globals.client, globals.project, globals.environment]
template_version  "2010-09-09"


# ssh key name that will be used
parameter :key_name do
  default :example
end

parameter :example_instance_type do
  default "m1.small"
end

# Security group for the example instance
resource "example_instance_security_group" do 
  type "AWS::EC2::SecurityGroup"
  properties do
    group_description "example security group"
    security_group_ingress globals.example_security_group_ingress + [
      {
        :ip_protocol => "tcp",
        :from_port => "8080",
        :to_port => "8080",
        :cidr_ip => "0.0.0.0/0",
      }
    ]
  end
end

# EC2 instance declaration
resource "example_instance" do
  type "AWS::EC2::Instance"
  properties do 
    key_name ref(:key_name)
    image_id ami_ids_ubuntu_ebs_20130624[ref("AWS::Region")][ aws_instance_type_to_arch[ref(:example_instance_type)]["Arch"] ]
    
    
    security_group_ids [ ref(:example_instance_security_group) ]
    
    instance_type ref(:example_instance_type)
    
    monitoring true
    tags globals.example_tags
    tags :function => "example"
    tags :name => "%s-%s-%s-%s" % [globals.client, globals.project, globals.environment, "example"]
  end
end
