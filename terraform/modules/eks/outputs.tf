# Terraform Outputs for EKS Module
output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_version" {
  value = aws_eks_cluster.main.version
}



# Output OIDC Provider Info
output "oidc_provider_url" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "oidc_issuer" {
  description = "oidc issuer"
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}
