variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "ami" {
  description = "AMI used for mongoDB hosts"

  default = {
    "eu-central-1" = "ami-1b4d9e74"
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
  default     = "r4.large"
}

variable "management_allowed_cidr" {
  description = "CIDR for allowed inbound management connections"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "opensensemap_subnets" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"
}
