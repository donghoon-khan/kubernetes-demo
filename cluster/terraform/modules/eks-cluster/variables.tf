variable "region" {
  description = "AWS Region"
  type = string
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
  type = bool
  default = true
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the cluster in"
  type = list(string)
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with an instance in a VPC"
  type = bool
  default = true
}

variable "allowed_security_groups" {
  description = "List of Security Group IDs to be allowed to connect to the EKS cluster"
  type = list(string)
  default = []
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks to be allowed to connect to the EKS cluster"
  type = list(string)
  default = []
}

variable "workers_role_arns" {
  description = "List of Role ARNs of the worker nodes"
  type = list(string)
}

variable "workers_security_group_ids" {
  description = "Security Group IDs of the worker nodes"
  type = list(string)
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
  type = string
  default = "1.14"
}

variable "oidc_provider_enabled" {
  description = "Create an IAM OIDC identity provider for the cluster"
  type = bool
  default = false
}

variable "endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type = bool
  default = false
}

variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type = bool
  default = true
}

variable "enabled_cluster_log_types" {
  description = "A list of the desired control plane logging to enable"
  type = list(string)
  default = []
}

variable "apply_config_map_aws_auth" {
  description = "Whether to generate local files from `kubeconfig` and `config-map-aws-auth`"
  type = bool
  default = true
}

variable "map_additional_aws_accounts" {
  description = "Additional AWS account numbers to add to `config-map-aws-auth` ConfigMap"
  type = list(string)
  default = []
}

variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn = string
    username = string
    groups = list(string)
  }))

  default = []
}

variable "map_additional_iam_users" {
  description = "Additional IAM users to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    userarn = string
    username = string
    groups = list(string)
  }))

  default = []
}

variable "kubeconfig_path" {
  description = "The path to `kubeconfig` file"
  type = string
  default = "~/.kube/config"
}

variable "local_exec_interpreter" {
  description = "Shell to use for local exec"
  type = string
  default = "/bin/bash"
}

variable "configmap_auth_template_file" {
  description = "Path to `config_auth_template_file`"
  type = string
  default = ""
}

variable "configmap_auth_file" {
  description = "Path to `configmap_auth_file`"
  type = string
  default = ""
}

variable "install_aws_cli" {
  description = "Set to `true` to install AWS CLI if the module is provisioned on workstations where AWS CLI is not installed"
  type = bool
  default = false
}

variable "install_kubectl" {
  description = "Set to `true` to install `kubectl` if the module is provisioned on workstations where `kubectl` is not installed by default"
  type = bool
  default = false
}

variable "kubectl_version" {
  description = "`kubectl` version to install. If not specified, the latest version will be used"
  type = string
  default = ""
}

variable "external_packages_install_path" {
  description = "Path to install external packages, e.g. AWS CLI and `kubectl`"
  type = string
  default = ""
}

variable "aws_eks_update_kubeconfig_additional_arguments" {
  description = "Additional arguments for `aws eks update-kubeconfig` command"
  type = string
  default = ""
}

variable "aws_cli_assume_role_arn" {
  description = "IAM Role ARN for AWS CLI to assume before calling `aws eks` to update `kubeconfig`"
  type = string
  default = ""
}

variable "aws_cli_assume_role_session_name" {
  description = "An identifier for the assumed role session when assuming the IAM Role for AWS CLI before calling `aws eks` to update `kubeconfig`"
  type = string
  default = ""
}

variable "jq_version" {
  description = "Version of `jq` to download to extract temporaly credentials after running `aws sts assume-role`"
  type = string
  default = "1.6"
}
