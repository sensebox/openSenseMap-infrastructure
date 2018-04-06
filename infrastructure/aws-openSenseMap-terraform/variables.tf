variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "ami" {
  description = "AMI used for mongoDB hosts"

  default = {
    "eu-central-1" = "ami-7c412f13"
  }
}

variable "ami_web" {
  description = "AMI used for mongoDB hosts"

  default = {
    "eu-central-1" = "ami-1c45e273"
  }
}

variable "ami_v2" {
  description = "AMI used for mongoDB hosts"

  default = {
    "eu-central-1" = "ami-5a922335"
  }
}

variable "aws_key_name" {
  description = "Key name used for hosts"
}

variable "aws_key_path" {
  description = "Path to the ssh key used for hosts"
}

variable "web_instance_type" {
  description = "instance type for web host"
  default     = "t2.medium"
}

variable "mongo_instance_type" {
  description = "instance type for mongoDB hosts"
  default     = "r4.xlarge"
}

variable "mongo_volume" {
  type = "map"

  default = {
    volume_type = "io1"
    volume_size = 40
    iops        = 1000
  }
}

variable "management_allowed_cidr" {
  description = "CIDR for allowed inbound management connections"
}

variable "mongo_enabled" {
  description = "controls if mongo hosts will be created. If true, 3 hosts will be created."
  default     = true
}

variable "web_enabled" {
  description = "controls if web host will be created."
  default     = true
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "opensensemap_subnets" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"
}
