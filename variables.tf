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


// VPN Server instance
variable "vpn_server_ami" {
  type        = string
  description = "AMI of VPN Server instance"
}

variable "vpn_server_type" {
  type        = string
  description = "Type of VPN Server instance"
}

variable "vpn_server_vol_type" {
  type        = string
  description = "Volume type of VPN Server instance"
}

variable "vpn_server_vol_size" {
  type        = string
  description = "Volume size of VPN Server instance"
}

