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