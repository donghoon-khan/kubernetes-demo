variable "subnet_type_tag_key" {
  description = "Key for subnet type tag to provide information about the type of subnets"
  type = string
  default = "eks-demo/subnet/type"
}

variable "subnet_type_tag_value_format" {
  description = "This is using the format interpolation symbols to allow the value of the subnet_type_tag_key to be modified"
  type = string
  default = "%s"
}

variable "max_subnet_count" {
  description = "Sets the maximum amount of subnets to deploy"
  default = 0
}

variable "vpc_id" {
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
  type = string
}

variable "igw_id" {
  description = "Internet Gateway ID the public route table will point to (e.g. `igw-9c26a123`)"
  type = string
}

variable "cidr_block" {
  description = "Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
  type = string
}

variable "availability_zones" {
  description = "List of Availability Zones where subnets will be created"
  type = list(string)
}

variable "vpc_default_route_table_id" {
  description = "Default route table for public subnets. If not set, will be created. (e.g. `rtb-f4f0ce12`)"
  type = string
  default = ""
}

variable "public_network_acl_id" {
  description = "Network ACL ID that will be added to public subnets"
  type = string
	default = ""
}

variable "private_network_acl_id" {
  description = "Network ACL ID that will be added to private subnets"
  type = string
  default = ""
}

variable "nat_gateway_enabled" {
  description = "Flag to enable/disable NAT Gateways to allow servers in the private subnets to access the Internet"
  type = bool
  default = true
}

variable "nat_instance_enabled" {
  description = "Flag to enable/disable NAT Instances to allow servers in the private subnets to access the Internet"
  type = bool
  default = false
}

variable "nat_instance_type" {
  description = "NAT Instance type"
  type = string
  default = "t3.micro"
}

variable "map_public_ip_on_launch" {
  description = "Instances launched into a public subnet should be assigned a public IP address"
  type = bool
  default = true
}
