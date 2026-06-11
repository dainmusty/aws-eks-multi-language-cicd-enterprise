#!/bin/bash

# Install ArgoCD and Nginx Ingress Controller
# This script installs ArgoCD and Nginx ingress controller on your Kubernetes cluster

# set -e  # Exit on error

echo "=== Installing ArgoCD ==="

# Create ArgoCD namespace
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Verify ArgoCD pods are running
echo "Waiting for ArgoCD pods to be ready..."
kubectl get pods -n argocd

echo ""
echo "=== ArgoCD Initial Setup ==="

# Get ArgoCD admin password
echo "Retrieving ArgoCD admin password..."
ARGOCD_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode)
echo "ArgoCD admin password: $ARGOCD_PASSWORD"

echo ""
echo "=== Accessing ArgoCD UI ==="
echo "To access ArgoCD GUI, run:"
echo "  kubectl port-forward svc/argocd-server -n argocd 8080:80"
echo "Then open: http://localhost:8080"
echo "Username: admin"
echo "Password: $ARGOCD_PASSWORD"

echo ""
echo "=== Installing Nginx Ingress Controller ==="

# Install Nginx ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo ""
echo "=== Installation Complete ==="
echo "All tools have been installed successfully!"