resource "aws_route53_zone" "testing_zone" {
  name = "${var.testing_dns_root_domain}"
}

resource "aws_route53_record" "testing_root" {
  zone_id = "${aws_route53_zone.testing_zone.zone_id}"
  name    = "${var.testing_dns_root_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.elastic_ip_testing.public_ip}"]
}

resource "aws_route53_record" "testing_www" {
  zone_id = "${aws_route53_zone.testing_zone.zone_id}"
  name    = "www.${var.testing_dns_root_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.elastic_ip_testing.public_ip}"]
}

resource "aws_route53_record" "testing_api" {
  zone_id = "${aws_route53_zone.testing_zone.zone_id}"
  name    = "api.${var.testing_dns_root_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.elastic_ip_testing.public_ip}"]
}

resource "aws_route53_record" "testing_ingress" {
  zone_id = "${aws_route53_zone.testing_zone.zone_id}"
  name    = "ingress.${var.testing_dns_root_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.elastic_ip_testing.public_ip}"]
}

resource "aws_route53_record" "testing_ttn" {
  zone_id = "${aws_route53_zone.testing_zone.zone_id}"
  name    = "ttn-integration.${var.testing_dns_root_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.elastic_ip_testing.public_ip}"]
}

resource "aws_route53_record" "testing_internet-test" {
  zone_id = "${aws_route53_zone.testing_zone.zone_id}"
  name    = "internet-test.${var.testing_dns_root_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.elastic_ip_testing.public_ip}"]
}
