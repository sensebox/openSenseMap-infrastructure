resource "aws_instance" "web" {
  count = 1

  ami                    = "${lookup(var.ami, var.aws_region)}"
  instance_type          = "${var.web_instance_type}"
  subnet_id              = "${element(data.aws_subnet_ids.opensensemap_subnets.ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.allow_all_outbound.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.mongo_internal.id}", "${aws_security_group.docker_external.id}"]
  key_name               = "${var.aws_key_name}"

  tags {
    Name    = "web"
    Project = "openSenseMap"
  }
}
