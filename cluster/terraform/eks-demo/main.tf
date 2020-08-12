provider "aws" {
  region = var.region
}

module "label" {
  source = "./../modules/null-label"
  namespace = var.namespace
  name = var.name
  stage = var.stage
  delimiter = var.delimiter
  attributes = compact(concat(var.attributes, list("cluster")))
  tags = var.tags
}

locals {
  tags = merge(module.label.tags, map("kubernetes.io/cluster/${module.label.id}", "shared"))
}

module "key_pair" {
  source = "./../modules/tls-ssh-key-pair"
  namespace = var.namespace
  stage = var.stage
  name = var.name
  attributes = var.attributes
  tls_key_algorithm = "RSA"
  private_key_extension = ".pem"
  public_key_extension = ".pub"
  ssh_key_path = path.cwd
}

module "vpc" {
  source = "./../modules/vpc"
  namespace = var.namespace
  stage = var.stage
  name = var.name
  attributes = var.attributes
  cidr_block = var.vpc_cidr_block
  tags = local.tags
}

module "subnets" {
  source = "./../modules/dynamic-subnets"
  availability_zones = var.availability_zones
  namespace = var.namespace
  stage = var.stage
  name = var.name
  attributes = var.attributes
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
  cidr_block = module.vpc.vpc_cidr_block
  nat_gateway_enabled = false
  nat_instance_enabled = false
  tags = local.tags
}

module "eks_cluster" {
  source = "./../modules/eks-cluster"
  namespace = var.namespace
  stage = var.stage
  name = var.name
  attributes = var.attributes
  tags = var.tags
  region = var.region
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.subnets.public_subnet_ids
  kubernetes_version = var.kubernetes_version
  kubeconfig_path = var.kubeconfig_path
  oidc_provider_enabled = var.oidc_provider_enabled

  workers_role_arns = [module.eks_node_group.eks_node_group_role_arn]
  workers_security_group_ids = []
}

module "eks_node_group" {
  source = "./../modules/eks-node-group"
  namespace = var.namespace
  stage = var.stage
  name = var.name
  attributes = var.attributes
  tags = var.tags
  subnet_ids = module.subnets.public_subnet_ids
  instance_types = var.instance_types
  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size
  ec2_ssh_key = module.key_pair.key_name
  cluster_name = module.eks_cluster.eks_cluster_id
  kubernetes_version = var.kubernetes_version
  kubernetes_labels = var.kubernetes_labels
}

module "ecr" {
  source = "./../modules/ecr"
  repo_names = var.ecr_repos
}
