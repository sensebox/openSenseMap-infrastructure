variable "testing_ami" {
  description = "AMI used for testing host"

  default = {
    "eu-central-1" = "ami-cd491726"
  }
}

variable "testing_instance_type" {
  description = "instance type for testing host"
  default     = "t2.micro"
}

variable "testing_dns_root_domain" {
  description = "dns root of testing instance"
}
