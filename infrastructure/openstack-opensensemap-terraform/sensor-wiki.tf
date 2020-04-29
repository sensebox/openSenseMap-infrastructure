resource "openstack_compute_instance_v2" "sensorwiki" {

  flavor_id = "${var.sensor_wiki_flavor}"
  name      = "sensorwiki"
  key_pair  = "${var.openstack_osem_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.osem_http.name}", "${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}", "${openstack_compute_secgroup_v2.docker_external.name}"]

  depends_on = ["openstack_networking_subnet_v2.internal-subnet"]


  block_device {
    uuid                  = "${var.ubuntu18_image_id}"
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = "${var.sensor_wiki_size}"
    volume_type           = "replicated_bronze"
  }
    
  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }
 
}

# Attach floating ip to instance
resource "openstack_compute_floatingip_associate_v2" "sensorwiki" {
  floating_ip        = "${var.sensor_wiki_floating_ip}"
  instance_id        = "${openstack_compute_instance_v2.sensorwiki.id}"
}