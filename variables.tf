variable "project_name" {
  type        = string
  description = "Project name prefix to resources names"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR - Public Network for VPC"

}

variable "map_public_ip_pub_network" {
  type        = bool
  description = "Auto MAP public IP for public network"
}

variable "map_public_ip_priv_network" {
  type        = bool
  description = "Auto MAP public IP for private network"
}

