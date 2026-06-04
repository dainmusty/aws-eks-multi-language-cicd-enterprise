locals {

  nat_gateway_count = (
    var.nat_strategy == "none"
      ? 0
      : var.nat_strategy == "single"
        ? 1
        : length(var.availability_zones)
  )

}

locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Project     = var.project_name
      Owner       = "DevOps-Team"
    }
  )
}