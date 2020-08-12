variable "region" {
  description = "AWS Region"
  type = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type = string
}

variable "namespace" {
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
  type = string
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev' or 'testing'"
  type = string
}

variable "name" {
  description = "Solution name, e.g. 'app' or 'cluster'"
  type = string
}

variable "delimiter" {
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
  type = string
  default = "-"
}

variable "attributes" {
  description = "Additional attributes (e.g. `1`)"
  type = list(string)
  default = []
}

variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
  type = map(string)
  default = {}
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
  type = string
  default = null
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type = number
}

variable "max_size" {
  description = "The maximum size of the AutoScaling Group"
  type = number
}

variable "min_size" {
  description = "The minimum size of the AutoScaling Group"
  type = number
}

variable "oidc_provider_enabled" {
  description = "Create an IAM OIDC identity provider for the cluster"
  type = bool
  default = false
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided"
  type = number
}

variable "instance_types" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]"
  type = list(string)
}

variable "ecr_repos" {
  description = "set of name of ECR"
  type = list(string)
}

variable "kubeconfig_path" {
  description = "The path to `kubeconfig` file"
  type = string
}

variable "kubernetes_labels" {
  description = "Key-value mapping of Kubernetes labels"
  type = map(string)
}
