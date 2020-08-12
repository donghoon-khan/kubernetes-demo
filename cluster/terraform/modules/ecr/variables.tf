variable "tags" {
  type = map(string)
  default = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`)"
}

variable "enabled" {
  type = bool
  description = "Set to false to prevent the module from creating any resources"
  default = true
}

variable "repo_names" {
	type = list(string)
	default = []
}

variable "use_fullname" {
  type = bool
  default = true
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`"
}

variable "principals_full_access" {
  type = list(string)
  description = "Principal ARNs to provide with full access to the ECR"
  default = []
}

variable "principals_readonly_access" {
  type = list(string)
  description = "Principal ARNs to provide with readonly access to the ECR"
  default = []
}

variable "scan_images_on_push" {
  type = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  default = false
}

variable "max_image_count" {
  description = "How many Docker Image versions AWS ECR will store"
  default = 500
}

variable "regex_replace_chars" {
  type = string
  default = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}
