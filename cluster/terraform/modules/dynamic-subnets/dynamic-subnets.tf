data "aws_vpc" "default" {
  id = var.vpc_id
}

data "aws_availability_zones" "available" {
}
