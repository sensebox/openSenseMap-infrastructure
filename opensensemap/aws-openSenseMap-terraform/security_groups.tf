resource "aws_security_group" "ssh_unims" {
  description = "allow ssh from ${var.ssh_allowed_cidr}"
  name        = "tf_ssh_unims"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_allowed_cidr}"]
  }

  tags {
    Project = "openSenseMap"
    Name    = "tf_ssh_unims"
  }
}

resource "aws_security_group" "allow_all_outbound" {
  name        = "tf_allow_all_outbound"
  description = "allow all outbound traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Project = "openSenseMap"
    Name    = "tf_allow_all_outbound"
  }
}

resource "aws_security_group" "mongo_internal" {
  name        = "tf_mongo_internal"
  description = "allow mongodb servers to communicate with each other"

  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    self      = true
  }

  tags {
    Project = "openSenseMap"
    Name    = "tf_mongo_internal"
  }
}

resource "aws_security_group" "opensensemap_group" {
  name        = "tf_opensensemap_external"
  description = "allow ingress traffic on tcp ports 80, 443 and 8000"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Project = "openSenseMap"
    Name    = "tf_opensensemap_external"
  }
}
