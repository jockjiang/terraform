variable "tenant" {
  description = "openstack tenant"
  type        = string
}

variable "url" {
  description = "openstack auth url"
  type        = string
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
  default     = "Hew$KKa5G9Zt*Hz3"
}

variable "domain" {
  description = "openstack domain"
  type        = string
  default     = "fusion"
}

