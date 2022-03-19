variable "region" {
    description = "the region for the opensearch"
    type = string
}
variable "elasticsearch_version" {
    description = "the version of the Opensearch"
    type = string
    default = "OpenSearch_1.1"
}
variable "domain" {
    description = "the domain name for opensearch"
    type = string
}
variable "instance_type" {
    description = "the instance type for the data node of opensearch"
    type = string
    default = "r6g.xlarge.search"
}
variable "master_instance_type" {
    description = "the instance type for the master node of opensearch"
    type = string
    default = "r6g.large.search"
}
variable "tag_domain" {
    description = "the tag for the domain"
    type = string
    default = "terraform"
}
variable "volume_type" {
    description = "the volume type for data node"
    type = string
    default = "gp2"
}
variable "ebs_volume_size" {
    description = "the volume size for the data node"
    type = number
    default = 10
}
variable "availability_zone_count" {
    description = "the available zone count for the opensearch domain"
    type = number
    default = 2
}
variable "subnet_ids" {
    description = "the subnet ids for opensearch domain, the number of subnet id is the same as availability_zone_count"
    type = list
}
variable "security_group_ids" {
    description = "the security group ids for the opensearch domain"
    type = list
}
variable "master_user_name" {
    description = "the master user name for the domain"
    type = string
    default = "jockjiang"
}
variable "master_user_password" {
    description = "the password of the master user name for the domain"
    type = string
}
variable "instance_count" {
    description = "the data node instance count, must x times the availability_zone_count"
    type = number
    default = 2
}
variable "master_instance_count" {
    description = "the instance number for master node"
    type = number
    default = 3
}

variable "log_group_name" {
    description = "the cloudwatch log group name"
    type = string
    default = "awsopensearch"
}

variable "log_group_policy" {
    description = "the cloudwatch log group policy name"
    type = string
    default = "awsopensearch"
}