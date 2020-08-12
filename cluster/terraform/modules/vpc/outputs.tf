output "igw_id" {
  description = "The ID of the Internet Gateway"
  value = aws_internet_gateway.default.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.default.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value = aws_vpc.default.cidr_block
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value = aws_vpc.default.main_route_table_id
}

output "vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value = aws_vpc.default.default_network_acl_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value = aws_vpc.default.default_security_group_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value = aws_vpc.default.default_route_table_id
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value = aws_vpc.default.ipv6_association_id
}

output "ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value = aws_vpc.default.ipv6_cidr_block
}
