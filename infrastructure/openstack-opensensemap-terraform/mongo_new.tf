resource "openstack_compute_instance_v2" "mongo_host_tb" {
  
  name    = "mongoDB_tb_${count.index}"
  count = "${var.mongo_enabled ? 1 : 0}"

  flavor_id = "${var.mongo_flavor}"
  image_id  = "${var.ubuntu18_image_id}"
  key_pair  = "${var.openstack_osem_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.mongo_internal_new.name}", "${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}"]

  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }

    block_device {
      uuid                  = "${var.ubuntu18_image_id}"
      source_type           = "image"
      destination_type      = "volume"
      boot_index            = 0
      delete_on_termination = true
      volume_size           = 12
      volume_type           = "replicated_gold"
    }

}

resource "openstack_blockstorage_volume_v2" "mongo_volume_tb" {

  count = "${var.mongo_enabled ? 1 : 0}"
  name  = "mongo_volume_tb_${count.index}"
  size  = "${var.mongo_size}"
  volume_type  = "replicated_gold"
}


resource "openstack_compute_volume_attach_v2" "mongo_tb" {
  count = "${var.mongo_enabled ? 1 : 0}"
  
  instance_id  = "${element(openstack_compute_instance_v2.mongo_host_tb.*.id, count.index)}"
  volume_id          = "${element(openstack_blockstorage_volume_v2.mongo_volume_tb.*.id, count.index)}"
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
