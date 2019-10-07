resource "openstack_compute_instance_v2" "mongo_host_arbiter" {
  
  name    = "mongoDB_arbiter"

  flavor_id = "medium"
  image_id  = "${var.ubuntu18_image_id}"
  key_pair  = "${var.openstack_osem_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.mongo_internal.name}", "${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}"]

  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }
}

resource "openstack_blockstorage_volume_v2" "mongo_volume_arbiter" {

  name  = "mongo_volume_arbiter"
  size  = "100"
}


resource "openstack_compute_volume_attach_v2" "mongo_arbiter" {
  
  instance_id  = "${openstack_compute_instance_v2.mongo_host_arbiter.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.mongo_volume_arbiter.id}"
}

resource "openstack_blockstorage_volume_v2" "mongo_arbiter_journal_volume" {

  name  = "mongo_arbiter_journal_volume"
  size  = 2
  volume_type  = "replicated_bronze"
}

resource "openstack_compute_volume_attach_v2" "mongo_arbiter_journal" {
  
  instance_id  = "${openstack_compute_instance_v2.mongo_host_arbiter.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.mongo_arbiter_journal_volume.id}"
}
