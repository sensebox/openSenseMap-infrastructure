resource "openstack_compute_instance_v2" "web" {
  # count = "${var.web_enabled ? 1 : 0}"

  flavor_id = "${var.web_flavor}"
  name      = "web"
  key_pair  = "${var.openstack_osem_keypair}"
  # image_id  = "${var.ubuntu18_image_id}"
  security_groups = ["${openstack_compute_secgroup_v2.osem_http.name}", "${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}", "${openstack_compute_secgroup_v2.docker_external.name}"]

  depends_on = ["openstack_networking_subnet_v2.internal-subnet"]


  block_device {
    uuid                  = "${var.ubuntu18_image_id}"
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = "${var.web_size}"
    volume_type           = "replicated_gold"
  }
  # provisioner "local-exec" {
  #     command = <<EOF
  # docker-machine create \
  #   --driver generic \
  #   --generic-ip-address ${openstack_compute_instance_v2.web.network.0.fixed_ip_v4} \
  #   --generic-ssh-user ubuntu \
  #   --generic-ssh-key ${var.openstack_key_path} \
  #   --engine-storage-driver overlay2 \
  #   opensensemap-web
  # EOF
  #   }


  #   provisioner "local-exec" {
  #     when    = "destroy"
  #     command = "docker-machine rm -f -y opensensemap-web"
  #   }
    
  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }
 
}

# Attach floating ip to instance
resource "openstack_compute_floatingip_associate_v2" "web" {
  floating_ip        = "${var.web_floating_ip}"
  instance_id        = "${openstack_compute_instance_v2.web.id}"
}
