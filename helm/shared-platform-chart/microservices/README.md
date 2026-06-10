# Microservices Helm Chart

A comprehensive Helm chart for deploying microservices on Kubernetes with support for multiple environments.

## Features

- **Multi-environment support**: Dev, staging, and production configurations
- **Scalability**: Horizontal Pod Autoscaling (HPA) for automatic scaling
- **High Availability**: Pod Disruption Budgets and pod anti-affinity
- **Security**: Network policies, RBAC, and security contexts
- **Observability**: ConfigMaps, secrets, and service accounts
- **Load Balancing**: Support for Ingress and service types

## Prerequisites

- Kubernetes 1.20+
- Helm 3.0+

## Installation

### Default Installation

```bash
helm install my-release .
```

### Install with Development Values

```bash
helm install my-release . -f values-dev.yaml
```

### Install with Staging Values

```bash
helm install my-release . -f values-staging.yaml
```

### Install with Production Values

```bash
helm install my-release . -f values-production.yaml
```

## Configuration

### Key Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `replicaCount` | 1 | Number of replicas |
| `image.repository` | nginx | Docker image repository |
| `image.tag` | 1.24 | Docker image tag |
| `service.type` | ClusterIP | Kubernetes service type |
| `ingress.enabled` | false | Enable ingress |
| `autoscaling.enabled` | false | Enable HPA |

For a complete list of parameters, see `values.yaml`.

## Upgrading

```bash
helm upgrade my-release . -f values.yaml
```

## Uninstalling

```bash
helm uninstall my-release
```

## Support

For issues and questions, please open an issue on the GitHub repository.


# Without PDB: Node drain kills all pods
kubectl drain node-1  # All 3 pods terminated → Service down!

# With PDB: Kubernetes respects minAvailable
kubectl drain node-1  # Waits for pods to reschedule before draining
# Result: Zero downtime during maintenance

# Test network policy
# Should work (allowed)
kubectl exec -it javascript-api-pod -- curl http://postgres:5432

# Should fail (blocked)
kubectl exec -it javascript-api-pod -- curl http://redis:6379
# Output: Connection timed out


# 2.5: Deployment Orchestration

# Single Helm Command Deploys All:
helm upgrade --install microservices ./helm/microservices \
  --values helm/microservices/values-production.yaml \
  --set javascriptApi.image.tag=$JS_TAG \
  --set javaService.image.tag=$JAVA_TAG \
  --set rustProcessor.image.tag=$RUST_TAG


  ### **2.6: Implementation Steps for Phase 2**

**Step 1: Create Service Structure**

```bash
mkdir -p services/{javascript-api,java-service,rust-processor}
```### **2.6: Implementation Steps for Phase 2**

**Step 1: Create Service Structure**

 # JavaScript
cd services/javascript-api/
npm init -y
npm install express

# Java
cd services/java-service/
spring init --dependencies=web

# Rust
cd services/rust-processor/
cargo new rust-processor

Step 3: Create Dockerfiles

Step 4: Create GitHub Actions Workflows

Step 5: Create Helm Chart
helm create microservices
# Customize with multiple deployments

Step 6: Test Locally
docker build -t js-api:test ./services/javascript-api
docker build -t java-svc:test ./services/java-service
docker build -t rust-proc:test ./services/rust-processor

# Environment-Specific Security Scanning
