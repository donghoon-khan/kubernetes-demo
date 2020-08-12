variable "namespace" {
  description = "Namespace (e.g. `eg` or `cp`)."
  type = string
  default = ""
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)."
  type = string
  default = ""
}

variable "name" {
  description = "Solution name."
  type = string
}

variable "delimiter" {
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`."
  type = string
  default = "-"
}

variable "attributes" {
  description = "Additional attributes (e.g. `1`)."
  type = list(string)
  default = []
}

variable "tags" {
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
  type = map(string)
  default = {}
}

variable "tls_key_algorithm" {
	description = "SSH Key algorithm."
  type  = string
  default = "RSA"
}

variable "private_key_extension" {
  description = "Private key extension."
  type = string
  default = ".pem"
}

variable "public_key_extension" {
  description = "Public key extension."
  type = string
  default = ".pub"
}

variable "aws_key_name" {
	description = "AWS key pair name."
	type = string
	default = ""
}

variable "ssh_key_path" {
	description = "Path to store (private, public)key."
	type = string
	default = ""
}

variable "chmod" {
  description = "Template of the command executed on the private key file."
  type = string
  default = "chmod 600 %v"
}
