### **Inline Suppressions for Accepted Risks**

**When security tools flag intentional decisions:**

// services/javascript-api/src/server.js

// nosemgrep: javascript.express.security.audit.express-check-csurf-middleware-usage.express-check-csurf-middleware-usage
// JUSTIFICATION: CSRF protection handled by API Gateway
// RISK: Medium - API is backend-only, no browser clients
// MITIGATION: API Gateway validates Origin headers
app.post("/api/data", (req, res) => {
  // ...
});

# terraform/modules/vpc/main.tf

# nosemgrep: terraform.aws.security.aws-vpc-public-subnet.aws-vpc-public-subnet
# JUSTIFICATION: NAT Gateway requires public subnet with internet gateway
# RISK: Low - Only NAT Gateway resides in public subnet, strict security groups
# MITIGATION: Network ACLs restrict traffic, no EC2 instances allowed
resource "aws_subnet" "public" {
  map_public_ip_on_launch = true
  # ...
}


**GitHub Environment Protection Rules:**

1. Go to Settings → Environments → production
2. Check “Required reviewers”
3. Add security team members
4. Require 2 approvals
5. Result: Production deploys only after security review



# Enterprise Terraform CI/CD — Plan & Apply Workflows

# Why Enterprise Teams Separate Terraform Plan and Apply

Separating Terraform planning from Terraform application is one of the most important infrastructure governance practices in modern platform engineering.

Instead of immediately deploying infrastructure changes after code is pushed, enterprise teams introduce validation, approvals, visibility, auditing, and security checks before infrastructure mutation occurs.

This architecture is widely used by:

* Enterprise platform engineering teams
* Site Reliability Engineering (SRE) teams
* Financial institutions
* Regulated environments (PCI-DSS, SOC2, HIPAA)
* Large Kubernetes platform organizations

---

# Enterprise Workflow Architecture

```text
Developer Push
      ↓
Terraform Validation
      ↓
Terraform Security Scanning
      ↓
Terraform Plan
      ↓
Approval / Review
      ↓
Terraform Apply
```

---

# Why Separate Workflows?

## 1. Separation of Responsibilities

| Workflow            | Responsibility                       |
| ------------------- | ------------------------------------ |
| terraform-plan.yml  | Safe validation and visibility       |
| terraform-apply.yml | Controlled infrastructure deployment |

This prevents infrastructure mutation during pull requests.

---

## 2. Enterprise Change Management

The plan stage allows:

* architects
* SREs
* security teams
* DevOps engineers

To review:

* resource changes
* IAM modifications
* networking changes
* Kubernetes updates
* cost impacts

before deployment.

---

## 3. Production Safety

Infrastructure deployment is dangerous.

Without separation:

```text
git push
   ↓
terraform apply
   ↓
production outage
```

Separating plan and apply dramatically reduces deployment risk.

---

## 4. Auditability

Enterprises need:

* deployment history
* approval records
* infrastructure change tracking
* compliance visibility

Separate workflows improve audit trails.

---

## 5. Environment Governance

Different environments require different controls.

| Environment | Governance         |
| ----------- | ------------------ |
| dev         | automatic          |
| staging     | optional approval  |
| production  | mandatory approval |

GitHub Environments integrate perfectly with this model.

---

# Final Enterprise Workflow Structure

```text
.github/workflows/

├── ci-platform.yml
├── terraform-plan.yml
├── terraform-apply.yml
│
├── javascript-api.yml
├── java-service.yml
├── rust-processor.yml
│
├── deploy-dev.yml
├── deploy-staging.yml
└── deploy-production.yml
```

---

# terraform-plan.yml

```yaml
name: Terraform Plan

on:
  pull_request:
    branches:
      - develop
      - main

    paths:
      - 'terraform/**'

permissions:
  id-token: write
  contents: read
  pull-requests: write

env:
  TF_VERSION: "1.12.2"
  AWS_REGION: us-east-1
  TF_PLUGIN_CACHE_DIR: ~/.terraform.d/plugin-cache

concurrency:
  group: terraform-plan-${{ github.ref }}
  cancel-in-progress: true

jobs:

  terraform-plan:

    name: Terraform Plan

    runs-on: ubuntu-latest

    strategy:
      fail-fast: false

      matrix:
        environment:
          - dev
          - staging
          - prod

    defaults:
      run:
        working-directory: terraform/environments/${{ matrix.environment }}

    steps:

      ######################################################
      # Checkout
      ######################################################

      - name: Checkout Repository
        uses: actions/checkout@v4

      ######################################################
      # Configure AWS Credentials (OIDC)
      ######################################################

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/github-actions-role
          aws-region: ${{ env.AWS_REGION }}

      ######################################################
      # Setup Terraform
      ######################################################

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ env.TF_VERSION }}

      ######################################################
      # Cache Terraform Plugins
      ######################################################

      - name: Cache Terraform Plugins
        uses: actions/cache@v4
        with:
          path: ~/.terraform.d/plugin-cache
          key: terraform-${{ runner.os }}-${{ hashFiles('**/.terraform.lock.hcl') }}

      ######################################################
      # Terraform Format
      ######################################################

      - name: Terraform Format Check
        run: terraform fmt -check -recursive

      ######################################################
      # Terraform Init
      ######################################################

      - name: Terraform Init
        run: terraform init

      ######################################################
      # Terraform Validate
      ######################################################

      - name: Terraform Validate
        run: terraform validate

      ######################################################
      # Terraform Plan
      ######################################################

      - name: Terraform Plan
        run: terraform plan -out=tfplan

      ######################################################
      # Terraform Show Plan
      ######################################################

      - name: Terraform Show Plan
        run: terraform show -no-color tfplan > plan.txt

      ######################################################
      # Upload Artifact
      ######################################################

      - name: Upload Plan Artifact
        uses: actions/upload-artifact@v4
        with:
          name: tfplan-${{ matrix.environment }}
          path: |
            terraform/environments/${{ matrix.environment }}/tfplan
            terraform/environments/${{ matrix.environment }}/plan.txt
          retention-days: 30
```

---

# terraform-apply.yml

```yaml
name: Terraform Apply

on:
  workflow_dispatch:
    inputs:
      environment:
        description: "Environment"
        required: true
        type: choice
        options:
          - dev
          - staging
          - prod

permissions:
  id-token: write
  contents: read

env:
  TF_VERSION: "1.12.2"
  AWS_REGION: us-east-1
  TF_PLUGIN_CACHE_DIR: ~/.terraform.d/plugin-cache

concurrency:
  group: terraform-apply-${{ inputs.environment }}
  cancel-in-progress: false

jobs:

  terraform-apply:

    name: Terraform Apply

    runs-on: ubuntu-latest

    environment:
      name: ${{ inputs.environment }}

    defaults:
      run:
        working-directory: terraform/environments/${{ inputs.environment }}

    if: github.ref == 'refs/heads/main'

    steps:

      ######################################################
      # Checkout
      ######################################################

      - name: Checkout Repository
        uses: actions/checkout@v4

      ######################################################
      # Configure AWS Credentials
      ######################################################

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/github-actions-role
          aws-region: ${{ env.AWS_REGION }}

      ######################################################
      # Setup Terraform
      ######################################################

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ env.TF_VERSION }}

      ######################################################
      # Cache Terraform Plugins
      ######################################################

      - name: Cache Terraform Plugins
        uses: actions/cache@v4
        with:
          path: ~/.terraform.d/plugin-cache
          key: terraform-${{ runner.os }}-${{ hashFiles('**/.terraform.lock.hcl') }}

      ######################################################
      # Terraform Init
      ######################################################

      - name: Terraform Init
        run: terraform init

      ######################################################
      # Download Plan Artifact
      ######################################################

      - name: Download Plan Artifact
        uses: actions/download-artifact@v4
        with:
          name: tfplan-${{ inputs.environment }}

      ######################################################
      # Terraform Apply
      ######################################################

      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
```

---

# Why These Enhancements Matter

# 1. Matrix Environment Validation

```yaml
strategy:
  matrix:
```

Benefits:

* validates all environments automatically
* catches drift early
* ensures environment consistency
* prevents staging/prod surprises

---

# 2. Path Filtering

```yaml
paths:
  - 'terraform/**'
```

Benefits:

* avoids unnecessary workflow runs
* reduces CI/CD costs
* improves pipeline speed
* important for monorepos

---

# 3. Terraform Plugin Caching

```yaml
TF_PLUGIN_CACHE_DIR
```

Benefits:

* faster pipeline execution
* reduced provider downloads
* lower CI runtime costs
* improves developer productivity

---

# 4. Concurrency Protection

```yaml
concurrency:
```

Benefits:

* prevents overlapping Terraform runs
* avoids state corruption risks
* prevents race conditions
* improves deployment safety

---

# 5. Artifact Retention

```yaml
retention-days: 30
```

Benefits:

* audit visibility
* rollback investigation
* deployment traceability
* compliance support

---

# 6. GitHub Environment Protection

```yaml
environment:
```

Benefits:

* production approvals
* deployment restrictions
* audit logging
* environment-specific secrets
* enterprise governance

---

# 7. Branch Restriction

```yaml
if: github.ref == 'refs/heads/main'
```

Benefits:

* prevents accidental applies
* protects production
* enforces deployment policy
* safer release process

---

# 8. OIDC Authentication

```yaml
aws-actions/configure-aws-credentials
```

Benefits:

* no AWS access keys
* temporary credentials
* reduced credential leakage risk
* enterprise cloud security best practice

---

# Enterprise-Level Concepts Demonstrated

This architecture demonstrates:

* Platform engineering
* Infrastructure governance
* Enterprise Terraform delivery
* Infrastructure security
* Production deployment safety
* CI/CD optimization
* Infrastructure auditability
* Cloud-native operational maturity

---

# Real-World Enterprise Alignment

This pattern aligns closely with practices used by:

* AWS platform teams
* Financial technology companies
* Kubernetes platform organizations
* SaaS infrastructure teams
* Enterprise DevOps organizations

---

# Final Outcome

You now have:

* enterprise-grade Terraform delivery
* secure infrastructure deployment
* auditable CI/CD pipelines
* scalable multi-environment governance
* production-safe infrastructure workflows

This is no longer a beginner DevOps setup.

This is now genuine platform engineering architecture.


# Recommended Workflow Structure
.github/workflows/

##################################################
# PLATFORM
##################################################

terraform-plan.yml

terraform-apply.yml

ci-platform.yml

##################################################
# SERVICE CI
##################################################

javascript-ci.yml

java-ci.yml

rust-ci.yml

##################################################
# ADVANCED DEMO
##################################################

multi-language-ci.yml

##################################################
# DEPLOYMENT
##################################################

deploy.yml
############################################################
# ENTERPRISE GITOPS DEPLOYMENT PIPELINE
#
# PURPOSE:
# - Promote applications across environments
# - Update Helm image tags
# - Trigger ArgoCD synchronization
#
# IMPORTANT:
# This workflow DOES NOT deploy directly.
#
# GitHub Actions:
#   updates Git
#
# ArgoCD:
#   deploys to Kubernetes
#
# ENTERPRISE FEATURES:
# - Environment promotion
# - Approval gates
# - GitOps workflow
# - Immutable image tags
# - Audit trail
############################################################

name: GitOps Deployment Pipeline

############################################################
# TRIGGERS
############################################################

on:

  ##########################################################
  # Manual promotion trigger
  ##########################################################

  workflow_dispatch:

    inputs:

      service:
        description: "Service to deploy"
        required: true
        type: choice

        options:
          - javascript-api
          - java-service
          - rust-processor

      environment:
        description: "Target environment"
        required: true
        type: choice

        options:
          - dev
          - staging
          - prod

      image_tag:
        description: "Docker image tag (usually Git SHA)"
        required: true
        type: string

############################################################
# PERMISSIONS
############################################################

permissions:
  contents: write
  pull-requests: write

############################################################
# CONCURRENCY CONTROL
############################################################

concurrency:
  group: deploy-${{ inputs.service }}-${{ inputs.environment }}
  cancel-in-progress: false

############################################################
# JOBS
############################################################

jobs:

  ##########################################################
  # DEPLOYMENT JOB
  ##########################################################

  deploy:

    name: Deploy to ${{ inputs.environment }}

    runs-on: ubuntu-latest

    ########################################################
    # GITHUB ENVIRONMENT PROTECTION
    #
    # Configure:
    # - dev → no approval
    # - staging → 1 approval
    # - prod → 2 approvals
    ########################################################

    environment:
      name: ${{ inputs.environment }}

    steps:

      ######################################################
      # STEP 1 — CHECKOUT REPOSITORY
      ######################################################

      - name: Checkout Repository
        uses: actions/checkout@v4

      ######################################################
      # STEP 2 — INSTALL YQ
      #
      # Used for safe YAML editing
      ######################################################

      - name: Install yq
        run: |
          sudo wget -O /usr/local/bin/yq \
          https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64

          sudo chmod +x /usr/local/bin/yq

      ######################################################
      # STEP 3 — UPDATE HELM IMAGE TAG
      #
      # This is the core GitOps step.
      #
      # Example:
      # image:
      #   tag: abc123
      ######################################################

      - name: Update Helm Values

        run: |

          VALUES_FILE="helm/${{ inputs.service }}/values-${{ inputs.environment }}.yaml"

          echo "Updating image tag in ${VALUES_FILE}"

          yq -i '
            .image.tag = "${{ inputs.image_tag }}"
          ' ${VALUES_FILE}

      ######################################################
      # STEP 4 — VERIFY CHANGES
      ######################################################

      - name: Verify Helm Changes
        run: |

          git diff

      ######################################################
      # STEP 5 — CONFIGURE GIT IDENTITY
      ######################################################

      - name: Configure Git User
        run: |
          git config user.name "github-actions"
          git config user.email "github-actions@github.com"

      ######################################################
      # STEP 6 — COMMIT CHANGES
      ######################################################

      - name: Commit Changes

        run: |

          git add .

          git commit -m "
          deploy(${{ inputs.environment }}):
          promote ${{ inputs.service }}
          image=${{ inputs.image_tag }}
          "

      ######################################################
      # STEP 7 — PUSH CHANGES
      #
      # THIS triggers ArgoCD sync.
      ######################################################

      - name: Push Changes
        run: |
          git push

      ######################################################
      # STEP 8 — DEPLOYMENT SUMMARY
      ######################################################

      - name: Deployment Summary

        run: |

          echo "======================================="
          echo " GITOPS DEPLOYMENT COMPLETED "
          echo "======================================="

          echo "Service:"
          echo "${{ inputs.service }}"

          echo ""

          echo "Environment:"
          echo "${{ inputs.environment }}"

          echo ""

          echo "Image Tag:"
          echo "${{ inputs.image_tag }}"

          echo ""

          echo "ArgoCD will now detect the Git change"
          echo "and synchronize automatically."