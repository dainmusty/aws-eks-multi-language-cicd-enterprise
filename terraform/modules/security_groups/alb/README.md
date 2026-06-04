# Terraform Infrastructure Guide

## Essential Commands
```bash
terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve
terraform reconfigure

# Targeted operations
terraform plan -target=resource.name
terraform apply -target=resource.name
```

## CloudFront & Route53 Integration Steps
1. Domain Setup:
   - Register domain in Route53 or transfer existing domain
   - Create hosted zone for your domain
   - Note the nameservers assigned to your hosted zone

2. CloudFront Distributions:
   - Create two CloudFront distributions (e.g., app.domain.com and api.domain.com)
   - Each distribution points to different ALB origins
   - Configure SSL certificates (ACM in us-east-1)
   - Set alternative domain names (CNAMEs)

3. Route53 Records:
   - Create A and AAAA records for each CloudFront distribution
   - Enable alias records pointing to CloudFront distributions
   - Add ALB DNS lookup record if needed

4. Dependencies Flow:
   ```
   Domain Registration
         ↓
   Hosted Zone Creation
         ↓
   SSL Certificate (ACM)
         ↓
   CloudFront Distributions
         ↓
   Route53 Records (A/AAAA)
         ↓
   ALB DNS Records
   ```

## Security Group Best Practices

Q: Should I manage all SGs in the sg module or keep the alb sg in alb.tf? What's best practice?

A: Keep all security groups in one dedicated module:
- SGs are cross-cutting resources
- Centralization ensures clear ownership
- Avoids duplicates/conflicts
- Tag SGs for clear identification
- Only use inline SGs if exclusively tied to one resource

For a startup, use role-based SGs:
- alb-sg
- web-sg (ASG instances)
- db-sg (RDS/Postgres)
- monitoring-sg (Prometheus/Grafana)

Q: Regarding variabilizing SG ports and descriptions?

A: Best practices:
1. Keep descriptions variabilized for compliance/audit changes
2. Use locals for common ports:
```hcl
locals {
  ssh_port = 22
  http_port = 80
  https_port = 443
  node_exporter_port = 9100
}
```
3. Restrict 0.0.0.0/0 in production
4. Break SGs into smaller, tier-based modules:
   - security-group-app
   - security-group-db
   - security-group-monitoring
   - security-group-alb

## Self-Referencing Security Groups
The `self = optional(bool)` parameter:
- Allows traffic from same security group
- Useful for DB replication/clustering
- Optional parameter in ingress rules
- Example:
```hcl
ingress_rules = [{
  description = "Allow MySQL from itself"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  self        = true
}]
```