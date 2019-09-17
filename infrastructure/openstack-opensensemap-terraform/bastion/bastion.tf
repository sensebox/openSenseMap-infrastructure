resource "openstack_compute_instance_v2" "bastion" {
  
  name    = "bastion"

  flavor_id = "${var.bastion_flavor}"
  image_id  = "${var.ubuntu18_image_id}"
  key_pair  = "${var.bastion_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.ssh_to_bastion.name}"]

  depends_on = ["openstack_networking_subnet_v2.internal-subnet"]

  network {
    uuid = "${openstack_networking_network_v2.internal.id}"
    name = "osem-internal"
  }
}
 
# Create volume
resource "openstack_blockstorage_volume_v2" "bastion" {
  name               = "bastion"
  size               = "${var.bastion_size}"
}

# Attach volume to instance instance testing
resource "openstack_compute_volume_attach_v2" "bastion" {
  instance_id        = "${openstack_compute_instance_v2.bastion.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.bastion.id}"
}

resource "openstack_compute_floatingip_associate_v2" "bastion" {
  floating_ip        = "${var.bastion_floating_ip}"
  instance_id        = "${openstack_compute_instance_v2.bastion.id}"
}