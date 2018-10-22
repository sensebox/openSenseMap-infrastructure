# # Request a spot instance at $0.0134
# resource "aws_spot_instance_request" "blockly_compiler" {
#   ami                  = "ami-475471ac"
#   spot_price           = "0.0134"
#   instance_type        = "t2.micro"
#   wait_for_fulfillment = true

#   vpc_security_group_ids = ["${aws_security_group.blockly_compiler.id}", "${aws_security_group.ssh_unims.id}", "${aws_security_group.allow_all_outbound.id}"]
#   key_name               = "${var.aws_key_name}"

#   root_block_device {
#     volume_size = "32"
#     volume_type = "gp2"
#   }

#   tags {
#     Name    = "blockly"
#     Project = "senseBox"
#   }
# }

resource "aws_eip" "elastic_ip_blockly_compiler" {
  vpc = true

  tags {
    Name = "blockly compiler"
  }
}

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = "${aws_spot_instance_request.blockly_compiler.spot_instance_id}"
#   allocation_id = "${aws_eip.elastic_ip_blockly_compiler.id}"
# }
