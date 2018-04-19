resource "aws_instance" "testing" {
  count = "1"

  ami                    = "${lookup(var.testing_ami, var.aws_region)}"
  instance_type          = "${var.testing_instance_type}"
  subnet_id              = "${element(data.aws_subnet_ids.opensensemap_subnets.ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.allow_all_outbound.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.docker_external.id}", "${aws_security_group.opensensemap_group.id}"]
  key_name               = "${var.aws_key_name}"

  root_block_device {
    volume_size = "16"
    volume_type = "gp2"
  }

  #   provisioner "local-exec" {
  #     command = <<EOF
  # docker-machine create \
  #   --driver generic \
  #   --generic-ip-address ${aws_instance.testing.public_ip} \
  #   --generic-ssh-user ubuntu \
  #   --generic-ssh-key ${var.aws_key_path} \
  #   --engine-storage-driver overlay2 \
  #   opensensemap-testing
  # EOF
  #   }


  #   provisioner "local-exec" {
  #     when    = "destroy"
  #     command = "docker-machine rm -f -y opensensemap-testing"
  #   }

  tags {
    Name    = "testing"
    Project = "openSenseMap"
  }
}

resource "aws_eip" "elastic_ip_testing" {
  instance = "${aws_instance.testing.id}"
  vpc      = true

  tags {
    Name = "testing"
  }
}
