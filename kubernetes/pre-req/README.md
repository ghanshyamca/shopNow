# Prerequisites

This directory contains prerequisite resources that need to be installed once per Kubernetes cluster.

## Files

### 1. metrics-server.yaml
Metrics Server is required for:
- Horizontal Pod Autoscaler (HPA) to work
- `kubectl top nodes` and `kubectl top pods` commands
- Resource monitoring and metrics collection

**Install:**
```bash
kubectl apply -f metrics-server.yaml
```

**Verify:**
```bash
kubectl get deployment metrics-server -n kube-system
kubectl top nodes
```

### 2. storageclass-gp3.yaml
AWS EBS gp3 StorageClass for persistent volumes.

**Requirements:**
- AWS EKS cluster
- EBS CSI Driver installed (via EKS Add-on)

**Install:**
```bash
kubectl apply -f storageclass-gp3.yaml
```

**Verify:**
```bash
kubectl get storageclass gp3-ssd
```

## Installation Order

1. First install the EBS CSI Driver (for AWS EKS):
   - Go to EKS Console → Your Cluster → Add-ons
   - Install "Amazon EBS CSI Driver"
   - Create IAM role with Pod Identity

2. Then apply these prerequisites:
```bash
kubectl apply -f metrics-server.yaml
kubectl apply -f storageclass-gp3.yaml
```

## Notes

- These resources only need to be installed once per cluster
- All other namespaced resources will use these
- For non-AWS clusters, use appropriate storage class for your provider
