# Ubuntu Precise (12.04 LTS) Release 20130624 EC2 AMIs for ebs Instance Types
# Source: http://cloud-images.ubuntu.com/locator/ec2/

ami_ids = {}
ami_ids["ap-northeast-1"] = {}
ami_ids["ap-northeast-1"]["64"] = "ami-51129850"
ami_ids["ap-northeast-1"]["32"] = "ami-4b12984a"

ami_ids["ap-southeast-1"] = {}
ami_ids["ap-southeast-1"]["64"] = "ami-a02f66f2"
ami_ids["ap-southeast-1"]["32"] = "ami-a22f66f0"

ami_ids["eu-west-1"] = {}
ami_ids["eu-west-1"]["64"] = "ami-89b1a3fd"
ami_ids["eu-west-1"]["32"] = "ami-8fb1a3fb"

ami_ids["sa-east-1"] = {}
ami_ids["sa-east-1"]["64"] = "ami-5c7edb41"
ami_ids["sa-east-1"]["32"] = "ami-227edb3f"

ami_ids["us-east-1"] = {}
ami_ids["us-east-1"]["64"] = "ami-23d9a94a"
ami_ids["us-east-1"]["32"] = "ami-21d9a948"

ami_ids["us-west-1"] = {}
ami_ids["us-west-1"]["64"] = "ami-c4072e81"
ami_ids["us-west-1"]["32"] = "ami-3a072e7f"

ami_ids["ap-southeast-2"] = {}
ami_ids["ap-southeast-2"]["64"] = "ami-974ddead"
ami_ids["ap-southeast-2"]["32"] = "ami-914ddeab"

ami_ids["us-west-2"] = {}
ami_ids["us-west-2"]["64"] = "ami-fb68f8cb"
ami_ids["us-west-2"]["32"] = "ami-f968f8c9"

mappings do
  ami_ids_ubuntu_ebs_20130624 ami_ids
end