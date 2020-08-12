module "nat_instance_label" {
  source = "./../null-label"
  context = module.label.context
  attributes = distinct(compact(concat(module.label.attributes, ["nat", "instance"])))
}

locals {
  nat_instance_count = var.nat_instance_enabled ? length(var.availability_zones) : 0
  cidr_block = var.cidr_block != "" ? var.cidr_block : data.aws_vpc.default.cidr_block
}

resource "aws_security_group" "nat_instance" {
  description = "Security Group for NAT Instance"
  count = var.nat_instance_enabled ? 1 : 0
  name = module.nat_instance_label.id
  vpc_id = var.vpc_id
  tags = module.nat_instance_label.tags
}

resource "aws_security_group_rule" "nat_instance_egress" {
  description = "Allow all egress traffic"
  count = var.nat_instance_enabled ? 1 : 0
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.nat_instance.*.id)
  type = "egress"
}

resource "aws_security_group_rule" "nat_instance_ingress" {
  description = "Allow ingress traffic from the VPC CIDR block"
  count = var.nat_instance_enabled ? 1 : 0
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [local.cidr_block]
  security_group_id = join("", aws_security_group.nat_instance.*.id)
  type = "ingress"
}

data "aws_ami" "nat_instance" {
  count = var.nat_instance_enabled ? 1 : 0
  most_recent = true

  filter {
    name = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "nat_instance" {
  count = local.nat_instance_count
  ami = join("", data.aws_ami.nat_instance.*.id)
  instance_type = var.nat_instance_type
  subnet_id = element(aws_subnet.public.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.nat_instance[0].id]

  tags = merge(
    module.nat_instance_label.tags,
    {
      "Name" = format(
        "%s%s%s",
        module.nat_label.id,
        var.delimiter,
        replace(
          element(var.availability_zones, count.index),
          "-",
          var.delimiter
        )
      )
    }
  )

  source_dest_check = false

  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "nat_instance" {
  count = local.nat_instance_count
  vpc   = true
  tags = merge(
    module.nat_instance_label.tags,
    {
      "Name" = format(
        "%s%s%s",
        module.nat_label.id,
        var.delimiter,
        replace(
          element(var.availability_zones, count.index),
          "-",
          var.delimiter
        )
      )
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip_association" "nat_instance" {
  count = local.nat_instance_count
  instance_id = element(aws_instance.nat_instance.*.id, count.index)
  allocation_id = element(aws_eip.nat_instance.*.id, count.index)
}

resource "aws_route" "nat_instance" {
  count = local.nat_instance_count
  route_table_id = element(aws_route_table.private.*.id, count.index)
  instance_id = element(aws_instance.nat_instance.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [aws_route_table.private]
}
