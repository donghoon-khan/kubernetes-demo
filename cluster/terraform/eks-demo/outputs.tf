output "eks_cluster_arn"  {
	description = "eks_cluster_arn : "
	value = module.eks_cluster.eks_cluster_arn
}

output "eks_cluster_endpoint" {
	description = "eks_cluster_endpoint : "
	value = module.eks_cluster.eks_cluster_endpoint
}

output "ECR_registry_URL" {
	description = "ECR Registry URL: "
	value = module.ecr.registry_url
}
