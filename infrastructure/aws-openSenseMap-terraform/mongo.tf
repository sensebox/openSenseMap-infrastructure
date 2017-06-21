resource "aws_instance" "mongo_host" {
  count = 3

  ami                    = "${lookup(var.ami, var.aws_region)}"
  instance_type          = "${var.mongo_instance_type}"
  subnet_id              = "${element(data.aws_subnet_ids.opensensemap_subnets.ids, count.index % 2)}"
  vpc_security_group_ids = ["${aws_security_group.allow_all_outbound.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.mongo_internal.id}"]
  key_name               = "${var.aws_key_name}"

  ebs_block_device {
    volume_type           = "io1"
    volume_size           = 40
    iops                  = 1000
    delete_on_termination = false
    device_name           = "/dev/xvdb"
  }

  tags {
    Name    = "mongoDB_${count.index}"
    Project = "openSenseMap"
  }
}
