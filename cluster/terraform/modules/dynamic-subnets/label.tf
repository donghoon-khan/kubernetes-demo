module "label" {
  source = "./../null-label"
  attributes = var.attributes
  namespace = var.namespace
  environment = var.environment
  stage = var.stage
  delimiter = var.delimiter
  name = var.name
  tags = var.tags
  additional_tag_map = var.additional_tag_map
  regex_replace_chars = var.regex_replace_chars
  label_order = var.label_order
  context = var.context
}

variable "namespace" {
  description = "Namespace (e.g. `eg` or `cp`)"
  type = string
  default = ""
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type = string
  default = ""
}

variable "environment" {
  description = "The environment name if not using stage"
  type = string
  default = ""
}

variable "name" {
  description = "Solution name"
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

variable "additional_tag_map" {
  description = "Additional tags for appending to each tag map"
  type = map(string)
  default = {}
}

variable "label_order" {
  description = "The naming order of the ID output and Name tag"
  type = list(string)
  default = []
}

variable "regex_replace_chars" {
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`"
  type = string
  default = "/[^a-zA-Z0-9-]/"
}

variable "context" {
  description = "Default context to use for passing state between label invocations"

  type = object({
    namespace = string
    environment = string
    stage = string
    name = string
    enabled = bool
    delimiter = string
    attributes = list(string)
    label_order = list(string)
    tags = map(string)
    additional_tag_map = map(string)
    regex_replace_chars = string
  })
  default = {
    namespace = ""
    environment = ""
    stage = ""
    name = ""
    enabled = true
    delimiter = ""
    attributes = []
    label_order = []
    tags = {}
    additional_tag_map = {}
    regex_replace_chars = ""
  }
}
