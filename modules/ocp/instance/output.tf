output "coordinator_node_ips" {
  value = openstack_compute_instance_v2.basic.*.access_ip_v4
}

output "worker_node_ips" {
  value = openstack_compute_instance_v2.basic.*.access_ip_v4
}
