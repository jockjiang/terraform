variable "network" {
  type        = string
  default     = "provider-3221"
}

variable "coordinator_type" {
  default = "ptc"
}

variable "worker_type" {
  default = "ptw"
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
  default     = "presto1"
}

variable "box_type" {
  description = "The type of Instances to run (e.g. cld/esd)"
  type        = string
}

variable "instances_count" {
  description = "The number of Instances "
  type        = number
}

variable "tenant" {
  description = "openstack tenant"
  type        = string
  default     = "WAP-Presto-Lab1"
}

variable "url" {
  description = "openstack auth url"
  type        = string
  default     = "https://ci22sj-keystone-srv.webex.com:443/v2.0"
}

variable "region" {
  type        = string
  default     = "sj-ssd-az1"
}

variable "coordinator_node_count" {
  type    = number
  default = 1
}

variable "coordinator_node_type" {
  type    = string
  # default = "4vcpu.8mem.80ssd.0eph"
  default = "4vcpu.32mem.80ssd.160eph"
}

variable "worker_node_count" {
  type    = number
  default = 1
}

variable "worker_node_type" {
  type    = string
  # default = "4vcpu.16mem.80ssd.2000eph"
  default = "4vcpu.32mem.80ssd.160eph"
}

variable "flavor_name" {
  type    = string
  # default = "4vcpu.8mem.80ssd.0eph"
  default = "4vcpu.32mem.80ssd.160eph"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------
variable "username" {
  description = "openstack username"
  type        = string
  default     = "clpbind2.gen"
}

variable "password" {
  description = "openstack password"
  type        = string
  # default     = "Hew$KKa5G9Zt*Hz3"
  default     = "sgcQOOgLefsWTAah"
}

variable "domain" {
  description = "openstack domain"
  type        = string
  default     = "fusion"
}

variable "image_name" {
  description = "The name of the image"
  type        = string
  default     = "CentOS-7-x86_64-harden-v2.1-12"
}
