resource "aws_instance" "web" {
  count = "${var.web_enabled ? 1 : 0}"

  ami                    = "${lookup(var.ami, var.aws_region)}"
  instance_type          = "${var.web_instance_type}"
  subnet_id              = "${element(data.aws_subnet_ids.opensensemap_subnets.ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.allow_all_outbound.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.mongo_internal.id}", "${aws_security_group.docker_external.id}"]
  key_name               = "${var.aws_key_name}"

  provisioner "local-exec" {
    command = <<EOF
docker-machine create \
  --driver generic \
  --generic-ip-address ${aws_instance.web.public_ip} \
  --generic-ssh-user ubuntu \
  --generic-ssh-key ${var.aws_key_path} \
  --engine-storage-driver overlay2 \
  opensensemap-web
EOF
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "docker-machine rm -f -y opensensemap-web"
  }

  tags {
    Name    = "web"
    Project = "openSenseMap"
  }
}
