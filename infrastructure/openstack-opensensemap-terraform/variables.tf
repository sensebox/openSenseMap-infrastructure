

# VARIABLES FOR WEB SERVER
variable "web_flavor" {
  default = "2xlarge"
}
variable "blockly_flavor" {
  default = "large"
}
variable "testing_flavor" {
  default = "medium"
}
variable "workshop_flavor" {
  default = "large"
}

variable "mongo_flavor" {
  default = "3xlarge"
}

variable "bastion_flavor" {
  default = "medium"
}

variable "openstack_osem_keypair" {
  default = "openstack"
}
variable "bastion_keypair" {
  default = "bastion key"
}
variable "web_size" {
  default = "250"
}
variable "mongo_size" {
  default = "500"
}
variable "testing_size" {
  default = "100"
}
variable "workshop_size" {
  default = "150"
}
variable "bastion_size" {
  default = "100"
}
variable "blockly_size" {
  default = "80"
}

#GENERAL VARIABLES

variable "ubuntu18_image_id" {
  default = "5cde5002-399c-4a66-a7bf-98db092f70d4"
}

variable "external_network_id" {
  default = "80fa37af-295e-489d-82bb-d1e6cd868f4b"
}
variable "uni_network_id" {
  default = "97ade255-7ec9-4d73-9c4c-c58d2cfcc653"
}

variable "management_allowed_cidr" {
  default = "192.168.1.0/24"
}

variable "web_floating_ip" {
  default = "128.176.196.25"
}

variable "bastion_floating_ip" {
  default = "128.176.196.28"
}

variable "testing_floating_ip" {
  default = "128.176.196.23"
}
variable "blockly_floating_ip" {
  default = "128.176.196.24"
}
variable "workshop_floating_ip" {
  default = "128.176.196.27"
}



variable "mongo_enabled" {
  description = "controls if mongo hosts will be created. If true, 3 hosts will be created."
  default     = true
}

variable openstack_key_name {
  default = "openstack"
} 

variable openstack_key_path {
  default = "/workdir/openstack.pem"
}


# variable "aws_region" {
#   default = "eu-central-1"
# }

# variable "aws_access_key" {}
# variable "aws_secret_key" {}

# variable "ami" {
#   description = "AMI used for mongoDB hosts"

#   default = {
#     "eu-central-1" = "ami-7c412f13"
#   }
# }

# variable "ami_mongodb_new" {
#   description = "AMI used for mongoDB hosts"

#   default = {
#     "eu-central-1" = "ami-027583e616ca104df"
#   }
# }

# variable "aws_key_name" {
#   description = "Key name used for hosts"
# }

# variable "aws_key_path" {
#   description = "Path to the ssh key used for hosts"
# }

# variable "web_instance_type" {
#   description = "instance type for web host"
#   default     = "t2.medium"
# }

# variable "web_ec2_instance_type" {
#   description = "instance type for web host"
#   default     = "t3.large"
# }

# variable "web_ami" {
#   description = "AMI used for web host"

#   default = {
#     "eu-central-1" = "ami-0bdf93799014acdc4"
#   }
# }

# variable "mongo_instance_type" {
#   description = "instance type for mongoDB hosts"
#   default     = "r4.xlarge"
# }

# variable "mongo_instance_type_new" {
#   description = "instance type for mongoDB hosts"
#   default     = "r4.2xlarge"
# }

# variable "mongo_volume" {
#   type = "map"

#   default = {
#     volume_type = "io1"
#     volume_size = 40
#     iops        = 1000
#   }
# }

# variable "management_allowed_cidr" {
#   description = "CIDR for allowed inbound management connections"
# }

# variable "mongo_enabled" {
#   description = "controls if mongo hosts will be created. If true, 3 hosts will be created."
#   default     = true
# }

# variable "web_enabled" {
#   description = "controls if web host will be created."
#   default     = true
# }

# data "aws_vpc" "default_vpc" {
#   default = true
# }

# data "aws_subnet_ids" "opensensemap_subnets" {
#   vpc_id = "${data.aws_vpc.default_vpc.id}"
# }
