output "ansible_hosts_ini" {
  value = "[all]\n${join(" ansible_user=ubuntu\n", openstack_compute_instance_v2.mongo_host.*.network.0.fixed_ip_v4)} \n${openstack_compute_instance_v2.web.network.0.fixed_ip_v4} ansible_user=ubuntu \n${openstack_compute_instance_v2.osem_testing.network.0.fixed_ip_v4} ansible_user=ubuntu\n\n [mongodb]\n${join(" ansible_user=ubuntu\n", openstack_compute_instance_v2.mongo_host.*.network.0.fixed_ip_v4)} ansible_user=ubuntu\n\n[webserver]\n${openstack_compute_instance_v2.web.network.0.fixed_ip_v4} ansible_user=ubuntu"
}
