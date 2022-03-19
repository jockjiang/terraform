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

locals {
    vcpu_list = {
        cld = 16
        cls = 4
        clw = 16
        clf = 4
        clr = 4        
        esd = 16
        esm = 4         
        esc = 8
        ptc = 4
        ptw = 4
    }
    ram_list = {
        cld = 192 * 1024
        cls = 32 * 1024
        clw = 128 * 1024
        clf = 32 * 1024
        clr = 32 * 1024
        esd = 64 * 1024
        esm = 32 * 1024
        esc = 64 * 1024
        ptc = 32 * 1024
        ptw = 32 * 1024
    }
    vcpu = lookup(local.vcpu_list, var.box_type)
    ram = lookup(local.ram_list, var.box_type)
  
    user_data = <<EOF
#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6HcjnxvBLTOi8SM5xwl+Db+2strmsko42hy64rM+3Nh9U+CkFa7aRkeiC/sHnpumd0X5jr07Md3uNgze0T6AsWr4UClrkB6dvzGQ0szRqnIicmOABz8WVQmDedkA/iFJml+VUlosRv7yElu+0x7Zq62oISDxhrTRleTqG84Cmb3YB+B+FTNpNwOvaNvZgk5J0LrOa1oH44WCkcoD4jgLjOzEq2b/ouSqej+E1YSXqcMRk8ckNrdmMmK/LQWwL/FkpGGI9ap444FzUbk2so5IVMJ1Gn5tP4vYp0UNeM1XK9i9ZKqvP+Uguks8BMcH8DjJFP7rFhPW68kfK1M6UnLbV jockj@JOCKJ-M-C6M3" | sudo tee /home/wbxbuilds/.ssh/authorized_keys
rm -fr /etc/yum.repos.d/*
EOF
}


data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}


data "openstack_images_image_v2" "image" {
  most_recent = true
  name        = var.image_name
}


resource "openstack_compute_instance_v2" "basic" {
  count           = var.instances_count
  name            = format("%s%s%03d.webex.com", var.cluster_name, var.box_type, count.index + 1)
  image_id        = try(data.openstack_images_image_v2.image.id)
  flavor_id       = try(data.openstack_compute_flavor_v2.flavor.id)
  security_groups = ["wappresto"]
  user_data = local.user_data

  network {
    name = var.network
  }
}
