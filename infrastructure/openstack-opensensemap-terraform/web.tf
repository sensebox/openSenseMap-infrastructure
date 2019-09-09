# resource "openstack_instance" "web" {
#   count = "${var.web_enabled ? 1 : 0}"

#   ami                    = "${lookup(var.ami, var.aws_region)}"
#   instance_type          = "${var.web_instance_type}"
#   subnet_id              = "${element(data.aws_subnet_ids.opensensemap_subnets.ids, count.index)}"
#   vpc_security_group_ids = ["${aws_security_group.allow_all_outbound.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.mongo_internal.id}", "${aws_security_group.docker_external.id}", "${aws_security_group.opensensemap_group.id}"]
#   key_name               = "${var.aws_key_name}"
#   monitoring             = true

#   root_block_device {
#     volume_size = "60"
#     volume_type = "gp2"
#   }

#   #   provisioner "local-exec" {
#   #     command = <<EOF
#   # docker-machine create \
#   #   --driver generic \
#   #   --generic-ip-address ${aws_instance.web.public_ip} \
#   #   --generic-ssh-user ubuntu \
#   #   --generic-ssh-key ${var.aws_key_path} \
#   #   --engine-storage-driver overlay2 \
#   #   opensensemap-web
#   # EOF
#   #   }


#   #   provisioner "local-exec" {
#   #     when    = "destroy"
#   #     command = "docker-machine rm -f -y opensensemap-web"
#   #   }

#   tags {
#     Name    = "web"
#     Project = "openSenseMap"
#   }
# }

resource "openstack_compute_instance_v2" "web" {
  # count = "${var.web_enabled ? 1 : 0}"

  flavor_id = "${var.web_flavor}"
  name      = "web"
  key_pair  = "${var.openstack_osem_keypair}"
  image_id  = "${var.ubuntu18_image_id}"
  security_groups = ["${openstack_compute_secgroup_v2.osem_http.id}", "${openstack_compute_secgroup_v2.ssh_from_bastion.id}"]

  depends_on = ["openstack_networking_subnet_v2.external-subnet"]

  #   provisioner "local-exec" {
  #     command = <<EOF
  # docker-machine create \
  #   --driver generic \
  #   --generic-ip-address ${openstack_compute_instance_v2.web.public_ip} \
  #   --generic-ssh-user ubuntu \
  #   --generic-ssh-key ${var.aws_key_path} \
  #   --engine-storage-driver overlay2 \
  #   --engine-opt log-driver=journald \
  #   opensensemap-web
  # EOF
  #   }
    
  network {
    uuid = "${openstack_networking_subnet_v2.external-subnet.network_id}"
    name = "osem-external"
  }
 
}

# Create volume
resource "openstack_blockstorage_volume_v2" "web" {
  name               = "web"
  size               = "${var.web_size}"
}

# Attach volume to instance instance web
resource "openstack_compute_volume_attach_v2" "web" {
  instance_id        = "${openstack_compute_instance_v2.web.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.web.id}"
}

# Attach floating ip to instance
resource "openstack_compute_floatingip_associate_v2" "web" {
  floating_ip        = "${var.web_floating_ip}"
  instance_id        = "${openstack_compute_instance_v2.web.id}"
}