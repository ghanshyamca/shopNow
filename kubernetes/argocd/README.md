# ShopNow ArgoCD - GitOps Configuration

This directory contains ArgoCD Application manifests for GitOps-based deployment of ShopNow.

## Overview

ArgoCD enables declarative, GitOps continuous delivery for Kubernetes applications. This setup includes:

- **Umbrella Application**: Parent application that manages all child applications
- **Child Applications**: Separate apps for MongoDB, Backend, Frontend, and Admin

## Structure

```
argocd/
├── README.md                    # This file
├── umbrella-application.yaml    # App of Apps pattern
└── apps/
    ├── mongo-app.yaml          # MongoDB application
    ├── backend-app.yaml        # Backend application
    ├── frontend-app.yaml       # Frontend application
    └── admin-app.yaml          # Admin application
```

## Prerequisites

1. **ArgoCD Installed**: Install ArgoCD in your cluster
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

2. **ArgoCD CLI** (optional but recommended):
   ```bash
   # macOS
   brew install argocd
   
   # Linux
   curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
   chmod +x /usr/local/bin/argocd
   ```

3. **Git Repository**: Push your code to a Git repository (GitHub, GitLab, etc.)

## Configuration

Before deploying, update these values in the YAML files:

1. **Git Repository URL**: Replace `<YOUR-GIT-REPO-URL>` with your actual repository URL
   - Example: `https://github.com/yourusername/shopnow.git`

2. **Target Revision**: Update `<YOUR-BRANCH>` with your branch name
   - Example: `main` or `master`

3. **Destination Server**: Usually `https://kubernetes.default.svc` for in-cluster

## Deployment Order

### Option 1: Using Umbrella Application (Recommended)

Deploy all applications at once using the App of Apps pattern:

```bash
# Apply the umbrella application
kubectl apply -f umbrella-application.yaml

# Verify applications
kubectl get applications -n argocd
```

### Option 2: Individual Applications

Deploy applications one by one:

```bash
# 1. Deploy MongoDB first
kubectl apply -f apps/mongo-app.yaml

# 2. Wait for MongoDB to be healthy
argocd app wait mongo -n argocd --health

# 3. Deploy Backend
kubectl apply -f apps/backend-app.yaml

# 4. Deploy Frontend and Admin
kubectl apply -f apps/frontend-app.yaml
kubectl apply -f apps/admin-app.yaml
```

## Access ArgoCD UI

```bash
# Port-forward ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Access UI at: https://localhost:8080
# Username: admin
# Password: <from above command>
```

## ArgoCD CLI Commands

```bash
# Login to ArgoCD
argocd login localhost:8080

# List applications
argocd app list

# Get application details
argocd app get shopnow-umbrella

# Sync application (manual deployment)
argocd app sync shopnow-umbrella

# View application logs
argocd app logs backend -n argocd

# Delete application
argocd app delete shopnow-umbrella
```

## Sync Policies

All applications are configured with:
- **Automated Sync**: Automatically syncs when Git repo changes
- **Prune**: Removes resources deleted from Git
- **Self Heal**: Reverts manual changes back to Git state

## Monitoring

Check application status:

```bash
# Using ArgoCD CLI
argocd app list

# Using kubectl
kubectl get applications -n argocd

# Check sync status
argocd app get backend --show-operation
```

## Troubleshooting

### Application OutOfSync

```bash
# Force sync
argocd app sync backend --force

# Check what's different
argocd app diff backend
```

### Connection Issues

```bash
# Verify ArgoCD is running
kubectl get pods -n argocd

# Check application events
kubectl describe application backend -n argocd
```

### Repository Authentication

If using private repository:

```bash
# Add repository credentials
argocd repo add <YOUR-REPO-URL> \
  --username <username> \
  --password <token>
```

## Benefits of GitOps with ArgoCD

1. **Single Source of Truth**: Git is the source of truth for all configurations
2. **Automated Sync**: Changes in Git automatically deployed to cluster
3. **Rollback**: Easy rollback by reverting Git commits
4. **Audit Trail**: Git history provides complete audit trail
5. **Security**: No kubectl access needed; push to Git instead

## Next Steps

1. Update repository URLs in all YAML files
2. Commit changes to Git
3. Apply umbrella application
4. Monitor sync status in ArgoCD UI
5. Verify all applications are healthy

## Additional Resources

- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [GitOps Principles](https://www.gitops.tech/)
- [App of Apps Pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/)
