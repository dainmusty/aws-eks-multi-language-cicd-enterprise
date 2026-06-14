# 🚀 AWS EKS Multi-Language GitOps CI/CD Enterprise Platform

Production-style cloud-native platform demonstrating Enterprise DevOps, GitOps, Kubernetes, Infrastructure as Code, Security Automation, and Polyglot Microservices deployment on AWS EKS.

---

## Table of Contents

* Overview
* Architecture
* Technology Stack
* Project Structure
* Screenshots
* CI/CD Architecture
* Deployment Strategies
* Security Strategy
* GitOps Deployment Model
* Environment Promotion Flow
* Rollback Strategy
* Monitoring & Observability
* Key Features
* Learning Outcomes
* Future Enhancements

---

# Overview

This project demonstrates an enterprise-grade GitOps platform supporting multiple application languages deployed to Kubernetes using AWS EKS.

The platform implements:

* Infrastructure as Code with Terraform
* GitOps with ArgoCD
* Kubernetes deployments using Helm
* Environment promotion pipelines
* Automated security scanning
* Docker image lifecycle management
* Multi-language CI/CD workflows
* Enterprise deployment patterns

The project includes:

* React Dashboard
* JavaScript API (Node.js)
* Java Spring Boot Service
* Rust Processor Service

---

# Architecture

![Architecture Diagram](docs/images/architecture-diagram.png)

```text
Developer
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ├── Security Scans
    ├── Unit Tests
    ├── Docker Build
    └── Image Push
    │
    ▼
GitOps Repository Update
    │
    ▼
ArgoCD
    │
    ▼
AWS EKS Cluster
    │
    ├── React Dashboard
    ├── JavaScript API
    ├── Java Service
    └── Rust Processor
```

---

# Technology Stack

| Category      | Technology                        |
| ------------- | --------------------------------- |
| Cloud         | AWS                               |
| Containers    | Docker                            |
| Orchestration | Kubernetes (EKS)                  |
| GitOps        | ArgoCD                            |
| IaC           | Terraform                         |
| Packaging     | Helm                              |
| CI/CD         | GitHub Actions                    |
| Frontend      | React                             |
| Backend       | Node.js                           |
| Backend       | Java Spring Boot                  |
| Backend       | Rust                              |
| Security      | Trivy, Gitleaks, Semgrep, Checkov |
| Monitoring    | Prometheus, Grafana               |

---

# Project Structure

```text
.
├── terraform/
├── helm/
│   ├── react-dashboard/
│   ├── javascript-api/
│   ├── java-service/
│   └── rust-processor/
│
├── polyglot-microservices/
│   ├── frontend/
│   └── backend/
│
├── k8s/
│   ├── bootstrap/
│   └── apps/
│
└── .github/workflows/
```

---

# Screenshots

### Operations Portal

The React Operations Portal provides a centralized view of platform health across all microservices.

![Operations Portal](docs/screenshots/dashboard-healthy.png)

## GitHub Actions Pipelines

Independent CI/CD pipelines for React, Node.js, Java, and Rust services.

![GitHub Actions Workflows](docs/screenshots/javascript-workflow.png)

![GitHub Actions Workflows](docs/screenshots/java-service-workflow.png)

![GitHub Actions Workflows](docs/screenshots/react-dashboard-workflow.png)

![GitHub Actions Workflows](docs/screenshots/rust-workflow.png)

![GitHub Actions Workflows](docs/screenshots/reusable-security-scanning-for-js-jv-rest-react.png)

![GitHub Actions Workflows](docs/screenshots/react-js-rust-java-tool-chain.png)

![GitHub Actions Workflows](docs/screenshots/docker-build-push.png)

## ArgoCD Applications

![ArgoCD Applications](docs/screenshots/argocd-applications.png)

### Development Environment

All services successfully deployed and healthy in the development environment.

![Development Environment](docs/screenshots/dev-environment.png)

### Staging Environment

Environment promotion from Development to Staging using GitOps workflows.

![Staging Environment](images/staging-environment.png)

---

# CI/CD Architecture

The platform implements service-specific CI pipelines.

```text
.github/workflows/

├── javascript-ci.yml
├── java-ci.yml
├── rust-ci.yml
├── react-ci.yml
├── deploy-dev.yml
├── deploy-staging.yml
├── deploy-production.yml
├── promote-release.yml
├── rollback.yml
└── release-summary.yml
```

Each service is independently built, tested, scanned, containerized, and deployed.

---

# Deployment Strategies

## Option A: Service-Specific CI Pipelines (Implemented)

```text
Developer Push
       │
       ▼
Language-Specific Pipeline
       │
       ├── Lint
       ├── Tests
       ├── Security Scan
       ├── Docker Build
       └── Docker Push
```

### Advantages

* Easier troubleshooting
* Clear ownership boundaries
* Faster onboarding
* Language-specific optimizations
* Better educational value
* Common enterprise pattern

### Disadvantages

* More workflow files
* Some duplicated logic
* Additional maintenance

### Best Use Cases

* Small and medium teams
* Polyglot environments
* Portfolio projects
* Microservice platforms

---

## Option B: Multi-Language Matrix Pipeline (Reference Architecture)

```text
Developer Push
       │
       ▼
Detect Changed Services
       │
       ▼
Parallel Matrix Builds
       │
       ├── Build
       ├── Scan
       └── Push
```

### Advantages

* Centralized governance
* Less duplicated code
* Better scaling

### Disadvantages

* Complex workflow logic
* Harder troubleshooting
* More difficult onboarding

### Best Use Cases

* Large organizations
* Platform engineering teams
* Internal developer platforms

---

## Project Recommendation

This project uses:

```text
Primary:
    Service-Specific Pipelines

Reference:
    Matrix-Based Pipeline
```

The service-specific model was selected because it offers the best balance between maintainability, clarity, scalability, and interview value.

---

# Security Strategy

Environment-aware security scanning is implemented.

---

## Development

```text
Branch:
    dev

Security:
    - Gitleaks
    - Basic Dependency Scanning

Goal:
    Fast Feedback
```

---

## Staging

```text
Branch:
    staging

Security:
    - Semgrep
    - OWASP Dependency Check
    - Cargo Audit
    - Checkov
    - Helm Lint

Goal:
    Pre-Production Validation
```

---

## Production

```text
Branch:
    main

Security:
    - Full Trivy Scan
    - SBOM Generation
    - Compliance Validation
    - Manual Approvals

Goal:
    Maximum Security
```

---

# GitOps Deployment Model

```text
Developer Push
        │
        ▼
GitHub Actions
        │
        ▼
Build Container Images
        │
        ▼
Push Images
        │
        ▼
Update Helm Values
        │
        ▼
Commit GitOps Changes
        │
        ▼
ArgoCD Sync
        │
        ▼
Kubernetes Deployment
```

---

# Environment Promotion Flow

```text
Feature Branch
      │
      ▼
DEV
      │
      ▼
STAGING
      │
      ▼
PRODUCTION
```

Each environment uses independent Helm values and deployment workflows.

---

# Rollback Strategy

## Git Revert (Recommended)

```bash
git revert <commit-id>
git push
```

ArgoCD automatically reconciles cluster state.

---

## ArgoCD Rollback

```bash
argocd app rollback <application>
```

---

## Helm Rollback

```bash
helm rollback <release> <revision>
```

---

# Monitoring & Observability

* Prometheus
* Grafana
* Kubernetes Metrics
* Node Exporter
* Application Health Checks

---

# Key Features

* AWS EKS Kubernetes Platform
* GitOps with ArgoCD
* Terraform Infrastructure as Code
* Helm Deployments
* Multi-Language Microservices
* Environment Promotion Pipelines
* Automated Security Scanning
* Docker Image Lifecycle Management
* Enterprise Deployment Workflows
* Rollback Automation

---

# Learning Outcomes

This project demonstrates practical experience with:

* Kubernetes Administration
* AWS EKS Operations
* Terraform
* GitHub Actions
* GitOps
* ArgoCD
* Helm
* Platform Engineering
* Security Automation
* Enterprise CI/CD Design

---

# Future Enhancements

* AWS Load Balancer Controller
* ExternalDNS
* Cert Manager
* Service Mesh (Istio)
* OpenTelemetry
* Multi-Region Deployments
* Policy-as-Code (OPA/Gatekeeper)
* Vault Integration
* Progressive Delivery with Argo Rollouts

```
```
