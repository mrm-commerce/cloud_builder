# Ubuntu Precise (12.04 LTS) Release 20130624 EC2 AMIs for instance-store Instance Types
# Source: http://cloud-images.ubuntu.com/locator/ec2/

ami_ids = {}
ami_ids["ap-northeast-1"] = {}
ami_ids["ap-northeast-1"]["64"] = "ami-7d1d977c"
ami_ids["ap-northeast-1"]["32"] = "ami-d31c96d2"

ami_ids["ap-southeast-1"] = {}
ami_ids["ap-southeast-1"]["64"] = "ami-b02f66e2"
ami_ids["ap-southeast-1"]["32"] = "ami-c22f6690"

ami_ids["eu-west-1"] = {}
ami_ids["eu-west-1"]["64"] = "ami-57b0a223"
ami_ids["eu-west-1"]["32"] = "ami-a5b2a0d1"

ami_ids["sa-east-1"] = {}
ami_ids["sa-east-1"]["64"] = "ami-027edb1f"
ami_ids["sa-east-1"]["32"] = "ami-ce7fdad3"

ami_ids["us-east-1"] = {}
ami_ids["us-east-1"]["64"] = "ami-d9d6a6b0"
ami_ids["us-east-1"]["32"] = "ami-bfd3a3d6"

ami_ids["us-west-1"] = {}
ami_ids["us-west-1"]["64"] = "ami-72072e37"
ami_ids["us-west-1"]["32"] = "ami-e6042da3"

ami_ids["ap-southeast-2"] = {}
ami_ids["ap-southeast-2"]["64"] = "ami-934ddea9"
ami_ids["ap-southeast-2"]["32"] = "ami-134dde29"

ami_ids["us-west-2"] = {}
ami_ids["us-west-2"]["64"] = "ami-5168f861"
ami_ids["us-west-2"]["32"] = "ami-ef67f7df"


mappings do
  ami_ids_ubuntu_instancestore_20130624 ami_ids
end