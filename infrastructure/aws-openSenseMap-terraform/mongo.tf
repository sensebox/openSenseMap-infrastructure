resource "aws_instance" "mongo_host" {
  count = "${var.mongo_enabled ? 3 : 0}"

  ami                    = "${lookup(var.ami, var.aws_region)}"
  instance_type          = "${var.mongo_instance_type}"
  subnet_id              = "${element(data.aws_subnet_ids.opensensemap_subnets.ids, count.index % 2)}"
  vpc_security_group_ids = ["${aws_security_group.allow_all_outbound.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.mongo_internal.id}"]
  key_name               = "${var.aws_key_name}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "32"
  }

  ebs_block_device {
    volume_type           = "${var.mongo_volume["volume_type"]}"
    volume_size           = "${var.mongo_volume["volume_size"]}"
    iops                  = "${var.mongo_volume["iops"]}"
    delete_on_termination = false
    device_name           = "/dev/xvdb"
  }

  tags {
    Name    = "mongoDB_${count.index}"
    Project = "openSenseMap"
  }
}
