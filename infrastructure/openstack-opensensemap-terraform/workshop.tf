resource "openstack_compute_instance_v2" "osem_workshop" {
  
  name    = "osem_workshop"

  flavor_id = "${var.workshop_flavor}"
  image_id  = "${var.ubuntu18_image_id}"
  key_pair  = "${var.openstack_osem_keypair}"
  security_groups = ["${openstack_compute_secgroup_v2.osem_http.name}", "${openstack_compute_secgroup_v2.ssh_from_bastion.name}", "${openstack_compute_secgroup_v2.prometheus_internal.name}", "${openstack_compute_secgroup_v2.docker_external.name}", "${openstack_compute_secgroup_v2.mongo_internal.name}"]
    
  # provisioner "local-exec" {
  #     command = <<EOF
  # docker-machine create \
  #   --driver generic \
  #   --generic-ip-address ${openstack_compute_instance_v2.osem_workshop.network.0.fixed_ip_v4} \
  #   --generic-ssh-user ubuntu \
  #   --generic-ssh-key ${var.openstack_key_path} \
  #   --engine-storage-driver overlay2 \
  #   opensensemap-workshop
  # EOF
  # }


  # provisioner "local-exec" {
  #   when    = "destroy"
  #   command = "docker-machine rm -f -y opensensemap-workshop"
  # }


  network {
    uuid = "${openstack_networking_subnet_v2.internal-subnet.network_id}"
    name = "osem-internal"
  }
}
 
# Create volume
resource "openstack_blockstorage_volume_v2" "osem_workshop" {
  name               = "osem_workshop"
  size               = "${var.workshop_size}"
}

# Attach volume to instance instance workshop
resource "openstack_compute_volume_attach_v2" "osem_workshop" {
  instance_id        = "${openstack_compute_instance_v2.osem_workshop.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.osem_workshop.id}"
}

resource "openstack_compute_floatingip_associate_v2" "osem_workshop" {
  floating_ip        = "${var.workshop_floating_ip}"
  instance_id        = "${openstack_compute_instance_v2.osem_workshop.id}"
}