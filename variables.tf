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



// Openstack Controller Node
variable "os_ctrl_node_server_ami" {
  type        = string
  description = "AMI of Openstack Controller Node Server instance"
}

variable "os_ctrl_node_server_type" {
  type        = string
  description = "Type of Openstack Controller Node Server instance"
}

variable "os_ctrl_node_server_vol_type" {
  type        = string
  description = "Volume type of Openstack Controller Node Server instance"
}

variable "os_ctrl_node_server_vol_size" {
  type        = string
  description = "Volume size of Openstack Controller Server instance"
}


// Openstack Computer Node
variable "os_comp_node_server_ami" {
  type        = string
  description = "AMI of Openstack Compute Node Server instance"
}

variable "os_comp_node_server_type" {
  type        = string
  description = "Type of Openstack Compute Node Server instance"
}

variable "os_comp_node_server_vol_type" {
  type        = string
  description = "Volume type of Openstack Compute Node Server instance"
}

variable "os_comp_node_server_vol_size" {
  type        = string
  description = "Volume size of Openstack Compute Server instance"
}

