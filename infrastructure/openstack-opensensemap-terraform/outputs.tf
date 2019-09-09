output "ansible_hosts_ini" {
  value = "[mongodb]\n${join(" ansible_user=ubuntu\n", openstack_compute_instance_v2.mongo_host.*.network.0.fixed_ip_v4)} ansible_user=ubuntu\n\n[webserver]\n${openstack_compute_instance_v2.web.network.0.fixed_ip_v4} ansible_user=ubuntu"
}
