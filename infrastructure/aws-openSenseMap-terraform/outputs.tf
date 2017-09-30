output "ansible_hosts_ini" {
  value = "[mongodb]\n${join(" ansible_user=ubuntu\n", aws_instance.mongo_host.*.public_ip)} ansible_user=ubuntu\n\n[webserver]\n${aws_instance.web.public_ip} ansible_user=ubuntu"
}

output "ansible_hosts_ini_v2" {
  value = "[mongodb]\n${join(" ansible_user=ubuntu\n", aws_instance.mongo_host_v2.*.public_ip)} ansible_user=ubuntu"
}
