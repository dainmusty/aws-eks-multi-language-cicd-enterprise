# =========================================================
# Local Values
# =========================================================

locals {

  cluster_name = "${var.project_name}-${var.environment}"

  node_group_config = {
    dev = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }

    staging = {
      instance_types = ["m5.large"]
      desired_size   = 3
      min_size       = 2
      max_size       = 6
    }

    prod = {
      instance_types = ["m5.2xlarge"]
      desired_size   = 6
      min_size       = 3
      max_size       = 10
    }
  }

  selected_node_group = local.node_group_config[var.environment]
}


# =========================================================
# Launch Template
# =========================================================

resource "aws_launch_template" "eks_nodes" {

  name_prefix = "${local.cluster_name}-lt"

  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.node_disk_size
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.tags, {
      Name = "${local.cluster_name}-node"
    })
  }

  tags = merge(var.tags, {
    Name = "${local.cluster_name}-launch-template"
  })
}

# =========================================================
# EKS Cluster
# =========================================================

resource "aws_eks_cluster" "main" {

  name     = local.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.environment == "production" ? false : true

    public_access_cidrs = (
    var.environment == "production"
  ? var.allowed_cidrs
  : ["0.0.0.0/0"]
)
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  encryption_config {
    provider {
      key_arn = var.key_arn
    }

    resources = ["secrets"]
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  depends_on = [
    var.cluster_policy_attachments,
    var.cloudwatch_log_group
  ]

  tags = merge(var.tags, {
    Name = "${local.cluster_name}-cluster"
  })
}

# =========================================================
# EKS Managed Node Group
# =========================================================

resource "aws_eks_node_group" "main" {

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.cluster_name}-node-group"

  node_role_arn = var.node_group_role_arn
  subnet_ids    = var.private_subnet_ids

  instance_types = local.selected_node_group.instance_types

  capacity_type = var.capacity_type

  ami_type = "AL2_x86_64"

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = local.selected_node_group.desired_size
    min_size     = local.selected_node_group.min_size
    max_size     = local.selected_node_group.max_size
  }

  update_config {
    max_unavailable_percentage = 33
  }

  labels = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  dynamic "taint" {

    for_each = var.environment == "production" ? [1] : []

    content {
      key    = "production"
      value  = "true"
      effect = "NO_SCHEDULE"
    }
  }

  tags = merge(var.tags, {

    Name = "${local.cluster_name}-nodes"

    "k8s.io/cluster-autoscaler/enabled" = "true"

    "k8s.io/cluster-autoscaler/${aws_eks_cluster.main.name}" = "owned"
  })

  depends_on = [
    var.node_policy_attachments
  ]
}

