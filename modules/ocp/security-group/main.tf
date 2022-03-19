terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.41.0"
    }
  }
}

provider "openstack" {
  user_name   = var.username
  tenant_name = var.tenant
  password    = var.password
  auth_url    = var.url
  domain_name = var.domain
}

data "openstack_networking_secgroup_v2" "default" {
  name = "default"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = try(data.openstack_networking_secgroup_v2.default.id)
}