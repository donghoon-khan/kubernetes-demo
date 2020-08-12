variable "namespace" {
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  type = string
  default = ""
}

variable "environment" {
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  type = string
  default = ""
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  type = string
  default = ""
}

variable "name" {
  description = "Solution name, e.g. 'app' or 'jenkins'"
  type = string
  default = ""
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type = bool
  default = true
}

variable "delimiter" {
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
  type = string
  default = "-"
}

variable "attributes" {
  description = "Additional attributes (e.g. `1`)"
  type = list(string)
  default = []
}

variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
  type = map(string)
  default = {}
}

variable "additional_tag_map" {
  description = "Additional tags for appending to each tag map"
  type = map(string)
  default = {}
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

variable "label_order" {
  description = "The naming order of the id output and Name tag"
  type = list(string)
  default = []
}

variable "regex_replace_chars" {
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`"
  type = string
  default = "/[^a-zA-Z0-9-]/"
}
