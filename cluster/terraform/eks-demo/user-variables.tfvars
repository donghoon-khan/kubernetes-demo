region = "ap-northeast-2"

availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

vpc_cidr_block = "172.16.0.0/16"

namespace = "eks"

stage = "dev"

name = "demo"

instance_types = ["t3.large"]

desired_size = 5

max_size = 10

min_size = 5

disk_size = 20

ecr_repos = ["eks-demo"]

kubeconfig_path = "~/.kube/config"

kubernetes_labels = {}

