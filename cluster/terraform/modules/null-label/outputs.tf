output "id" {
  description = "Disambiguated ID"
  value = local.enabled ? local.id : ""
}

output "name" {
  description = "Normalized name"
  value = local.enabled ? local.name : ""
}

output "namespace" {
  description = "Normalized namespace"
  value = local.enabled ? local.namespace : ""
}

output "stage" {
  description = "Normalized stage"
  value = local.enabled ? local.stage : ""
}

output "environment" {
  description = "Normalized environment"
  value = local.enabled ? local.environment : ""
}

output "attributes" {
  description = "List of attributes"
  value = local.enabled ? local.attributes : []
}

output "delimiter" {
  description = "Delimiter between `namespace`, `environment`, `stage`, `name` and `attributes`"
  value = local.enabled ? local.delimiter : ""
}

output "tags" {
  description = "Normalized Tag map"
  value = local.enabled ? local.tags : {}
}

output "tags_as_list_of_maps" {
  description = "Additional tags as a list of maps, which can be used in several AWS resources"
  value = local.tags_as_list_of_maps
}

output "context" {
  description = "Context of this module to pass to other label modules"
  value = local.output_context
}

output "label_order" {
  description = "The naming order of the id output and Name tag"
  value = local.label_order
}

