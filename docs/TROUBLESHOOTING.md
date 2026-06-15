# TROUBLESHOOTING.md

# Kubernetes & EKS Troubleshooting Guide

This document contains real-world troubleshooting scenarios commonly encountered in Kubernetes, EKS, GitOps, and microservices environments.

---

# Table of Contents

1. CrashLoopBackOff
2. Pod Stuck in Pending
3. Service Not Reachable
4. Persistent Volume Claim Pending
5. High CPU / Memory Usage
6. Helm Upgrade Failure
7. ImagePullBackOff
8. Readiness Probe Failures
9. ArgoCD Sync Failures
10. GitHub Actions Deployment Failures
11. EKS Node Not Ready
12. ALB Ingress Issues

---

# Scenario 1: CrashLoopBackOff

## Symptom

```bash
kubectl get pods

NAME                    READY   STATUS             RESTARTS
api-deployment-abc123   0/1     CrashLoopBackOff   5
```

## Investigation

### Check Pod Events

```bash
kubectl describe pod api-deployment-abc123
```

### Check Current Logs

```bash
kubectl logs api-deployment-abc123
```

### Check Previous Logs

```bash
kubectl logs api-deployment-abc123 --previous
```

### Inspect Exit Code

```bash
kubectl get pod api-deployment-abc123 \
-o jsonpath='{.status.containerStatuses[0].lastState.terminated.exitCode}'
```

Common Exit Codes:

| Code | Meaning            |
| ---- | ------------------ |
| 1    | Application error  |
| 137  | OOMKilled          |
| 139  | Segmentation fault |
| 143  | SIGTERM            |

## Common Fixes

### Missing Secret

```yaml
env:
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: db-secret
      key: url
```

### Database Not Ready

```yaml
initContainers:
- name: wait-for-db
  image: busybox
  command:
    - sh
    - -c
    - until nc -z postgres 5432; do sleep 2; done
```

### OOMKilled

```yaml
resources:
  requests:
    memory: "512Mi"
  limits:
    memory: "1Gi"
```

---

# Scenario 2: Pod Stuck in Pending

## Symptom

```bash
kubectl get pods

STATUS: Pending
```

## Investigation

```bash
kubectl describe pod <pod-name>
```

Common causes:

### Insufficient Resources

```text
0/3 nodes available: Insufficient memory
```

### Node Selector Mismatch

```text
0/3 nodes matched node selector
```

### PVC Missing

```text
PVC not found
```

### Taints / Tolerations

```bash
kubectl describe nodes
```

## Fix

### Verify Node Labels

```bash
kubectl get nodes --show-labels
```

### Verify PVC

```bash
kubectl get pvc
```

### Add Toleration

```yaml
tolerations:
- key: node-role.kubernetes.io/control-plane
  operator: Exists
  effect: NoSchedule
```

---

# Scenario 3: Service Not Reachable

## Symptom

```bash
curl http://api-service:3000

Connection refused
```

## Investigation

### Verify Service

```bash
kubectl get svc api-service
```

### Verify Endpoints

```bash
kubectl get endpoints api-service
```

Empty endpoints usually indicate label mismatch.

### Verify Selector

```bash
kubectl get svc api-service -o yaml
```

### Verify Pod Labels

```bash
kubectl get pods -l app=api
```

### Debug From Cluster

```bash
kubectl run debug \
--image=nicolaka/netshoot \
-it --rm -- /bin/bash
```

```bash
curl http://api-service:3000/health
```

### DNS Verification

```bash
nslookup api-service
```

### CoreDNS Health

```bash
kubectl logs -n kube-system \
-l k8s-app=kube-dns
```

### Network Policies

```bash
kubectl get networkpolicies
```

### Port Mismatch

Service:

```yaml
targetPort: 8080
```

Container:

```yaml
containerPort: 3000
```

These must match.

---

# Scenario 4: Persistent Volume Claim Pending

## Symptom

```bash
kubectl get pvc

STATUS: Pending
```

## Investigation

```bash
kubectl describe pvc data-claim
```

Common causes:

### Missing StorageClass

```bash
kubectl get storageclass
```

### EBS CSI Driver Issue

```bash
kubectl logs \
-n kube-system \
-l app=ebs-csi-controller
```

### IAM Permissions Missing

```text
UnauthorizedOperation:
ec2:CreateVolume
```

### Availability Zone Mismatch

Use:

```yaml
volumeBindingMode: WaitForFirstConsumer
```

---

# Scenario 5: High CPU or Memory Usage

## Symptom

```bash
kubectl top pods
```

Example:

```text
CPU: 950m
Memory: 1800Mi
```

## Investigation

### Check Restart Count

```bash
kubectl get pod <pod>
```

### Check Pod Age

Older pods may indicate memory leaks.

### Java Heap Dump

```bash
jmap -dump:live,format=b,file=/tmp/heapdump.hprof <PID>
```

### Node.js CPU Profile

```bash
kill -SIGUSR1 <PID>
```

### Active Connections

```bash
netstat -an | grep ESTABLISHED
```

## Fix

```yaml
resources:
  requests:
    cpu: "250m"
    memory: "512Mi"

  limits:
    cpu: "1000m"
    memory: "1Gi"
```

Enable HPA for scaling.

---

# Scenario 6: Helm Upgrade Failed

## Symptom

```bash
helm upgrade myapp ./chart

UPGRADE FAILED
```

## Investigation

### Check Differences

```bash
helm diff revision myapp 4 5
```

### Recent Events

```bash
kubectl get events \
--sort-by='.lastTimestamp'
```

## Rollback

```bash
helm rollback myapp 4
```

## Prevention

```bash
helm upgrade myapp ./chart \
--dry-run \
--debug
```

```bash
helm upgrade myapp ./chart \
--atomic
```

---

# Scenario 7: ImagePullBackOff

## Symptom

```bash
kubectl get pods

STATUS: ImagePullBackOff
```

## Investigation

### Describe Pod

```bash
kubectl describe pod <pod>
```

### Verify Image Exists

```bash
aws ecr describe-images \
--repository-name api
```

### Verify IAM Permissions

Required:

```text
ecr:GetAuthorizationToken
ecr:BatchGetImage
ecr:GetDownloadUrlForLayer
```

### Verify Service Account

```bash
kubectl describe sa
```

### Verify Image Pull Secrets

```bash
kubectl get secrets
```

## Recommended Fix

Use IRSA:

```yaml
serviceAccountName: api-sa
```

---

# Scenario 8: Readiness Probe Failure

## Symptom

```text
Readiness probe failed
HTTP probe returned 500
```

## Investigation

### Manual Test

```bash
kubectl exec <pod> -- \
curl http://localhost:3000/ready
```

### Check Logs

```bash
kubectl logs <pod>
```

### Check Dependency Connectivity

```bash
nc -zv postgres 5432
```

## Recommended Configuration

```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 3000

  initialDelaySeconds: 10
  periodSeconds: 5
```

---

# Scenario 9: ArgoCD Sync Failure

## Symptom

```text
OutOfSync
Sync Failed
```

## Investigation

```bash
argocd app get myapp
```

```bash
kubectl get events
```

## Common Causes

* Invalid manifests
* Missing namespaces
* Missing CRDs
* Helm rendering errors

## Fix

```bash
argocd app sync myapp
```

```bash
helm template .
```

Validate before committing.

---

# Scenario 10: GitHub Actions Deployment Failure

## Common Causes

### Docker Login Failure

```bash
docker login
```

Verify:

```text
DOCKER_USERNAME
DOCKER_PASSWORD
```

### Git Push Permission Denied

```text
403 Permission Denied
```

Fix:

```yaml
permissions:
  contents: write
```

### Missing Git Identity

```bash
git config user.name
git config user.email
```

---

# Scenario 11: EKS Node Not Ready

## Investigation

```bash
kubectl get nodes
```

```bash
kubectl describe node <node>
```

### Verify CNI

```bash
kubectl get pods -n kube-system
```

### Verify Node Group

```bash
aws eks describe-nodegroup
```

---

# Scenario 12: ALB Ingress Issues

## Symptom

```text
Ingress created
No ALB provisioned
```

## Investigation

### Verify ALB Controller

```bash
kubectl get pods \
-n kube-system \
-l app.kubernetes.io/name=aws-load-balancer-controller
```

### Check Controller Logs

```bash
kubectl logs \
-n kube-system deployment/aws-load-balancer-controller
```

### Verify Ingress Class

```yaml
ingressClassName: alb
```

### Verify Subnet Tags

```text
kubernetes.io/role/elb=1
```

Required for ALB discovery.

---

# Recommended Troubleshooting Order

```text
1. Pod Status
2. Pod Events
3. Container Logs
4. Service & Endpoints
5. Ingress
6. Storage
7. Networking
8. Node Health
9. Cluster Health
10. GitOps / ArgoCD
```

Following this order resolves most Kubernetes incidents within minutes instead of hours.
