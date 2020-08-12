variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type = string
  default = ""
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type = string
  default = ""
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type = string
}

variable "delimiter" {
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
  type = string
  default = "-"
}

variable "attributes" {
  description = "Additional attributes (e.g. `1`)"
  type = list(string)
  default = []
}

variable "tags" {
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
  type = map(string)
  default = {}
}

variable "cidr_block" {
  description = "CIDR for the VPC"
  type = string
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type = string
  default = "default"
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type = bool
  default = true
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type = bool
  default = true
}

variable "enable_classiclink" {
  description = "A boolean flag to enable/disable ClassicLink for the VPC"
  type = bool
  default = false
}

variable "enable_classiclink_dns_support" {
  description = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC"
  type = bool
  default = false
}
