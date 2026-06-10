# module "eks" {
#   source = "../../../modules/eks"

#   project_name           = "startup"
#   environment            = "dev"
#   kubernetes_version     = "1.27"
#   private_subnet_ids     = module.dev_vpc.private_subnet_ids
#   allowed_cidrs          = ["10.0.0.0/16"]
#   cluster_role_arn       = module.iam_core.admin_role_arn
#   node_group_role_arn    = module.iam_core.admin_role_arn
#   cluster_policy_attachments = {
#     eks_cluster_policy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   }
#   node_policy_attachments = {
#     eks_worker_node_policy      = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#     eks_cni_policy              = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#     eks_container_registry      = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
#   }
#   capacity_type          = "ON_DEMAND"
#   node_disk_size         = 50
#   log_retention_days     = 30
#   key_arn                = "" # Add KMS key ARN if available
#   cloudwatch_log_group   = "dev-eks-logs"
#   tags = {
#     Environment = "dev"
#     Project     = "Startup"
#   }
# }