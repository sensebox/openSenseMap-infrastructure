resource "openstack_compute_instance_v2" "mongo_host_new" {
  
  name    = "mongoDB_new_${count.index}"
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

resource "openstack_blockstorage_volume_v2" "mongo_volume_new" {

  count = "${var.mongo_enabled ? 3 : 0}"
  name  = "mongo_volume_new_${count.index}"
  size  = "${var.mongo_size}"
  volume_type  = "replicated_gold"
}


resource "openstack_compute_volume_attach_v2" "mongo_new" {
  count = "${var.mongo_enabled ? 3 : 0}"
  
  instance_id  = "${element(openstack_compute_instance_v2.mongo_host_new.*.id, count.index)}"
  volume_id          = "${element(openstack_blockstorage_volume_v2.mongo_volume_new.*.id, count.index)}"
}


# resource "openstack_blockstorage_volume_v2" "mongo_journal_volume" {

#   count = "${var.mongo_enabled ? 3 : 0}"
#   name  = "mongo_volume_${count.index}"
#   size  = 16
#   volume_type  = "replicated_gold"
# }

# resource "openstack_compute_volume_attach_v2" "mongo_journal" {
#   count = "${var.mongo_enabled ? 3 : 0}"
  
#   instance_id  = "${element(openstack_compute_instance_v2.mongo_host.*.id, count.index)}"
#   volume_id          = "${element(openstack_blockstorage_volume_v2.mongo_journal_volume.*.id, count.index)}"
# }
