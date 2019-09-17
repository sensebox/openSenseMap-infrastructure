resource "openstack_compute_secgroup_v2" "osem_http" {
  name        = "osem_http"
  description = "Allow Http and Https"

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

   rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 8000
    to_port     = 8000
    ip_protocol    = "tcp"
    cidr = "0.0.0.0/0"
  }

}

resource "openstack_compute_secgroup_v2" "ssh_to_bastion" {
  name    = "ssh_to_bastion"
  description = "Allow ssh from everywhere"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  
  rule {
    from_port   = 302
    to_port     = 302
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "ssh_from_bastion" {
  name    = "ssh_from_bastion"
  description = "Allow ssh from bastion"
  
  # rule {
  #   from_port   = 22
  #   to_port     = 22
  #   ip_protocol = "tcp"
  #   cidr        = "${var.management_allowed_cidr}"
  # }


// TODO:CHECK IF THIS WORKS
  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "${openstack_compute_instance_v2.bastion.network.0.fixed_ip_v4}/32"
  }
}

resource "openstack_compute_secgroup_v2" "mongo_internal" {
  name        = "tf_mongo_internal"
  description = "allow mongodb servers to communicate with each other"

  rule {
    from_port    = 27017
    to_port      = 27017
    ip_protocol  = "tcp"
    self         = true
  }
}

resource "openstack_compute_secgroup_v2" "docker_external" {
  name        = "tf_docker_external"
  description = "allow ingress traffic on tcp port 2376 for docker from ${var.management_allowed_cidr}"

  rule {
    from_port     = 2376
    to_port       = 2376
    ip_protocol   = "tcp"
    cidr          = "${var.management_allowed_cidr}"
  }
}
resource "openstack_compute_secgroup_v2" "prometheus_internal" {
  name        = "tf_prom_internal"
  description = "allow ingress traffic on tcp port 9100 for prometheus from ${var.management_allowed_cidr}"

  rule {
    from_port     = 9100
    to_port       = 9100
    ip_protocol   = "tcp"
    cidr          = "${var.management_allowed_cidr}"
  }
}

resource "openstack_compute_secgroup_v2" "blockly_compiler" {
  name        = "tf_blockly_compiler"
  description = "allow ingress traffic on tcp ports 80 and 443"

  rule {
    from_port      = 80
    to_port        = 80
    ip_protocol    = "tcp"
    cidr           = "0.0.0.0/0"
  }

  rule {
    from_port     = 443
    to_port       = 443
    ip_protocol   = "tcp"
    cidr          = "0.0.0.0/0"
  }
}