# 🚀 Enterprise Polyglot Microservices Platform on AWS EKS

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?style=for-the-badge&logo=kubernetes)
![Helm](https://img.shields.io/badge/Helm-Packaging-0F1689?style=for-the-badge&logo=helm)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?style=for-the-badge)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?style=for-the-badge&logo=githubactions)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Observability-F46800?style=for-the-badge&logo=grafana)

---

# 🌟 Project Summary

This project demonstrates how to build and operate a **production-grade Platform Engineering ecosystem** using:

- AWS EKS
- Terraform
- Helm
- ArgoCD GitOps
- GitHub Actions
- Prometheus & Grafana
- Multi-Language Microservices
- Enterprise Security Controls

The platform deploys and manages:

| Service | Language | Framework |
|----------|-----------|------------|
| JavaScript API | Node.js | Express |
| Java Service | Java | Spring Boot |
| Rust Processor | Rust | Actix Web |

---

# 🏗 Enterprise Architecture

```text
                   ┌────────────────────┐
                   │    Developers      │
                   └─────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │      GitHub         │
                  └─────────┬───────────┘
                            │
                            ▼
              ┌────────────────────────────┐
              │     GitHub Actions CI      │
              └──────────┬─────────────────┘
                         │
         ┌───────────────┼──────────────────┐
         │               │                  │
         ▼               ▼                  ▼

   JavaScript CI     Java CI          Rust CI

         │               │                  │
         └───────────────┼──────────────────┘
                         │
                         ▼

              Security Scanning Layer

                         │
                         ▼

                    Amazon ECR

                         │
                         ▼

                GitOps Configuration

                         │
                         ▼

                      ArgoCD

                         │
                         ▼

                    Amazon EKS

                         │
      ┌──────────────────┼──────────────────┐
      ▼                  ▼                  ▼

 JavaScript API     Java Service     Rust Processor
```

---

# 🎯 Architecture Highlights

### Infrastructure as Code

- Terraform Modules
- Remote State Management
- Environment Isolation
- Reusable Infrastructure Components

### Kubernetes Platform Engineering

- Amazon EKS
- AWS Load Balancer Controller
- Horizontal Pod Autoscaling
- Network Policies
- Service Accounts
- Pod Disruption Budgets

### GitOps

- ArgoCD App-of-Apps
- Environment Promotion
- Self-Healing Clusters
- Drift Detection

### CI/CD

- Language-Specific Pipelines
- Matrix Builds
- Docker Image Optimization
- Security Gates

### Observability

- Prometheus
- Grafana
- AlertManager

---

# 📂 Repository Structure

```text
polyglot-microservices/

├── terraform/
│
├── services/
│   ├── javascript-api/
│   ├── java-service/
│   └── rust-processor/
│
├── helm/
│   ├── per-service-charts/
│   └── shared-platform-chart/
│
├── gitops/
│   ├── dev/
│   ├── staging/
│   └── production/
│
├── argocd/
│   ├── root-app.yaml
│   └── projects/
│
└── .github/workflows/
```

---

# 🚀 CI/CD Workflow

```text
Developer Push
       │
       ▼
GitHub Actions
       │
       ▼
Unit Tests
       │
       ▼
Security Scans
       │
       ▼
Docker Build
       │
       ▼
Push to Amazon ECR
       │
       ▼
Update Helm Values
       │
       ▼
GitOps Commit
       │
       ▼
ArgoCD Sync
       │
       ▼
Deploy to Kubernetes
```

---

# 🔐 Enterprise Security Strategy

## Development

Fast Feedback

- Gitleaks
- Critical Dependency Checks
- Linting

Runtime:

< 2 minutes

---

## Staging

Comprehensive Security Validation

- Semgrep
- OWASP Dependency Check
- Cargo Audit
- tfsec
- Checkov

Runtime:

5-7 minutes

---

## Production

Maximum Security

- Container Scanning
- DAST
- Compliance Validation
- Security Reports

Runtime:

10-15 minutes

---

# 🌎 Environment Promotion Model

```text
Feature Branch
      │
      ▼
Develop
      │
      ▼
DEV Environment
      │
      ▼
Staging Branch
      │
      ▼
STAGING Environment
      │
      ▼
Main Branch
      │
      ▼
PRODUCTION Environment
```

---

## Approval Gates

| Environment | Approval |
|------------|------------|
| DEV | Automatic |
| STAGING | 1 Reviewer |
| PRODUCTION | 2 Reviewers + Security Approval |

---

# 🔄 Rollback Strategy

## Git Revert (Preferred)

```bash
git revert HEAD
git push
```

ArgoCD automatically restores the previous release.

---

## ArgoCD Rollback

```bash
argocd app rollback
```

---

## Helm Rollback

```bash
helm rollback
```

Emergency use only.

---

# 📊 Monitoring & Alerting

### Metrics

- Cluster Health
- Node Health
- Pod Health
- Application Metrics
- Container Metrics

### Alerts

- High CPU Usage
- High Memory Usage
- Pod Crash Loops
- Node Down
- Service Unavailable

### Dashboards

- EKS Cluster Dashboard
- Node Exporter Dashboard
- Application Dashboard
- Infrastructure Dashboard

---

# 🧠 Key Engineering Concepts Demonstrated

✅ Infrastructure as Code

✅ Platform Engineering

✅ GitOps

✅ Kubernetes Operations

✅ Cloud Security

✅ Production CI/CD

✅ Multi-Language Architectures

✅ Release Engineering

✅ Disaster Recovery

✅ Observability

---

# 📸 Screenshots

> Add these after deployment

### EKS Cluster

![eks](docs/screenshots/eks-cluster.png)

### ArgoCD Applications

![argocd](docs/screenshots/argocd-applications.png)

### GitHub Actions

![gha](docs/screenshots/github-actions.png)

### Grafana Dashboards

![grafana](docs/screenshots/grafana-dashboard.png)

# CI/CD Pipeline Strategy

This project demonstrates **two enterprise-grade CI/CD approaches** commonly used in modern platform engineering teams.

---

## Option A: Service-Specific CI Pipelines (Primary Approach)

Each microservice owns its own CI pipeline.

```text
.github/workflows/
├── javascript-ci.yml
├── java-ci.yml
├── rust-ci.yml
```

### Workflow

```text
Developer Push
        │
        ▼
Language-Specific CI
        │
        ├── Lint
        ├── Unit Tests
        ├── Build
        ├── Security Scans
        ├── Docker Build
        └── Push to ECR
```

### Advantages

* Easier troubleshooting
* Clear ownership boundaries
* Language-specific optimization
* Faster onboarding for new engineers
* Easier interview demonstrations
* Mirrors how many enterprises operate polyglot platforms

### Disadvantages

* More workflow files
* Some duplicated logic
* Additional maintenance as service count grows

### Best Use Cases

* Small and medium engineering teams
* Polyglot microservice environments
* Organizations with fewer than 20 services
* Educational and portfolio projects

---

## Option B: Multi-Language Matrix Pipeline (Advanced Approach)

A single workflow dynamically builds only changed services.

```text
.github/workflows/
└── multi-language-ci.yml
```

### Workflow

```text
Developer Push
        │
        ▼
Detect Changed Services
        │
        ├── JavaScript Changed?
        ├── Java Changed?
        └── Rust Changed?
                 │
                 ▼
         Parallel Matrix Build
                 │
                 ├── Docker Build
                 ├── Security Scan
                 └── Push to ECR
```

### Advantages

* Centralized governance
* Less duplicated workflow code
* Scales efficiently to many services
* Preferred by large platform engineering teams
* Demonstrates advanced GitHub Actions skills

### Disadvantages

* More complex workflow logic
* Harder troubleshooting
* More difficult onboarding
* Language-specific customization becomes harder

### Best Use Cases

* Large organizations
* Internal developer platforms
* Platform engineering teams
* Organizations managing dozens of microservices

---

## Project Recommendation

This project uses:

```text
Primary CI Strategy:
    Service-Specific Pipelines

Advanced Reference:
    Multi-Language Matrix Pipeline
```

The service-specific approach is used as the primary implementation because it provides:

* Better maintainability
* Easier debugging
* Clear service ownership
* Better educational value

The matrix pipeline remains in the repository as an advanced platform-engineering reference implementation.

---

# Security Strategy

This project implements environment-aware security scanning to balance developer productivity with enterprise security requirements.

---

## Development Environment

```text
Branch:
    develop

Security Controls:
    - Gitleaks
    - Critical Dependency Scanning
    - Linting

Goal:
    Fast developer feedback
```

---

## Staging Environment

```text
Branch:
    staging

Security Controls:
    - Semgrep SAST
    - OWASP Dependency Check
    - Cargo Audit
    - Checkov
    - Helm Lint

Goal:
    Catch security issues before production
```

---

## Production Environment

```text
Branch:
    main

Security Controls:
    - Full Security Suite
    - Trivy Repository Scan
    - SBOM Generation
    - Compliance Validation
    - Manual Approval Gates

Goal:
    Maximum security and compliance
```

---

# GitOps Deployment Model

This project follows a GitOps deployment model using ArgoCD.

---

## Deployment Flow

```text
Developer Push
        │
        ▼
GitHub Actions CI
        │
        ▼
Build Container Images
        │
        ▼
Push Images to ECR
        │
        ▼
Update GitOps Manifests
        │
        ▼
Commit Back to Git
        │
        ▼
ArgoCD Detects Change
        │
        ▼
Kubernetes Deployment
```

---

## Environment Promotion Flow

```text
Feature Branch
      │
      ▼
Develop
      │
      ▼
DEV Deployment
      │
      ▼
Staging
      │
      ▼
STAGING Deployment
      │
      ▼
Production Approval
      │
      ▼
MAIN
      │
      ▼
PRODUCTION Deployment
```

---

## Rollback Strategy

### Option 1 (Recommended)

Git Revert

```bash
git revert <commit-id>
git push
```

ArgoCD automatically rolls back the deployment.

---

### Option 2

ArgoCD Rollback

```bash
argocd app rollback <application>
```

---

### Option 3

Helm Rollback

```bash
helm rollback <release> <revision>
```

Used primarily for emergency recovery scenarios.

---

# Enterprise Enhancements (Future Roadmap)

The platform is intentionally designed to support future enterprise-grade enhancements.

Potential future improvements include:

* OIDC Authentication for GitHub Actions
* Cross-Account ECR Promotion
* Argo Rollouts (Blue/Green Deployments)
* Canary Releases
* Progressive Delivery
* Cosign Image Signing
* SBOM Attestation
* Open Policy Agent (OPA)
* Kyverno Policy Enforcement
* Multi-Region EKS Deployments
* Disaster Recovery Automation
* ArgoCD Notifications
* Automated Compliance Reporting

These enhancements represent common evolution paths for mature enterprise Kubernetes platforms.
---

# 👨‍💻 Author

Platform Engineering | DevOps | Cloud Infrastructure

Built to demonstrate enterprise-grade Kubernetes, GitOps, security automation, observability, and cloud-native deployment practices.