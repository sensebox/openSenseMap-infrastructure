resource "openstack_compute_instance_v2" "data_exporter" {

  flavor_id = "${var.sensor_wiki_flavor}"
  name      = "data_exporter"
  key_pair  = "${var.openstack_osem_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}", "${openstack_compute_secgroup_v2.docker_external.name}", "${openstack_compute_secgroup_v2.mongo_internal.name}"] 

  depends_on = ["openstack_networking_subnet_v2.internal-subnet"]


  block_device {
    uuid                  = "${var.ubuntu18_image_id}"
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = "${var.data_exporter_size}"
    volume_type           = "replicated_bronze"
  }
    
  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }
}