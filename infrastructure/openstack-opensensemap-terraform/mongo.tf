resource "openstack_compute_instance_v2" "mongo_host" {
  
  name    = "mongoDB_${count.index}"
  count = "${var.mongo_enabled ? 3 : 0}"

  flavor_id = "${var.mongo_flavor}"
  image_id  = "${var.ubuntu18_image_id}"
  key_pair  = "${var.openstack_osem_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.mongo_internal.name}", "${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}"]

  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }
}

resource "openstack_blockstorage_volume_v2" "mongo_volume" {

  count = "${var.mongo_enabled ? 3 : 0}"
  name  = "mongo_volume_${count.index}"
  size  = "${var.mongo_size}"
}


resource "openstack_compute_volume_attach_v2" "mongo" {
  count = "${var.mongo_enabled ? 3 : 0}"
  
  instance_id  = "${element(openstack_compute_instance_v2.mongo_host.*.id, count.index)}"
  volume_id          = "${element(openstack_blockstorage_volume_v2.mongo_volume.*.id, count.index)}"
}
