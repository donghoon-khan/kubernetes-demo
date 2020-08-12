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

variable "enabled" {
  description = "Whether to create the resources"
  type = string
  default = "true"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type = string
}

variable "ec2_ssh_key" {
  description = "SSH key name that should be used to access the worker nodes"
  type = string
  default = null
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type = number
}

variable "min_size" {
	description = "Minimum number of worker nodes"
  type = number
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type = list(string)
}

variable "existing_workers_role_policy_arns" {
  description = "List of existing policy ARNs that will be attached to the workers default role on creation"
  type = list(string)
  default = []
}

variable "existing_workers_role_policy_arns_count" {
  description = "Count of existing policy ARNs that will be attached to the workers default role on creation"
  type = number
  default = 0
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type = string
  default = "AL2_x86_64"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type = number
  default = 20
}

variable "instance_types" {
  description = "Set of instance types associated with the EKS Node Group"
  type = list(string)
}

variable "kubernetes_labels" {
  description = "Key-value mapping of Kubernetes labels"
  type = map(string)
  default = {}
}

variable "ami_release_version" {
  description = "AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version"
  type = string
  default = null
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type = string
  default = null
}

variable "source_security_group_ids" {
  description = "Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes"
  type = list(string)
  default = []
}
