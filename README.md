# ShopNow - E-Commerce MERN Application

**Hero Vired DevOps Assignment**: Kubernetes deployment with HELM charts and Jenkins CI/CD automation

## 📋 Assignment Requirements

This project fulfills the Hero Vired assignment requirements:

1. ✅ **Kubernetes Deployment Files**: Complete manifests for MongoDB, Backend (Express.js), Frontend (React), and Admin (React)
2. ✅ **HELM Charts**: Templated charts for all components with parameterized configurations
3. ✅ **Jenkins Groovy Pipelines**: CI/CD automation for building Docker images and deploying to Kubernetes

**Source Repository**: https://github.com/mohanDevOps-arch/shopNow

---

A full-stack e-commerce platform built with MongoDB, Express.js, React, and Node.js, deployed on Kubernetes using HELM charts and automated with Jenkins CI/CD pipelines.

## 🚀 Project Overview

**Hero Vired DevOps Assignment**: Kubernetes deployment with HELM charts and Jenkins automation for a MERN stack e-commerce application.

### Assignment Requirements (Core Deliverables):
1. ✅ **Kubernetes Deployment Files**: Complete manifests for frontend, backend, and MongoDB
2. ✅ **HELM Charts**: Templated charts for streamlined deployment and configuration
3. ✅ **Jenkins Groovy Pipelines**: CI/CD automation for build and deployment

### Application Features:
- **Customer Frontend**: Browse products, add to cart, place orders
- **Admin Dashboard**: Manage products, orders, and inventory
- **REST API Backend**: Node.js/Express API with MongoDB
- **Container Orchestration**: Kubernetes deployment with auto-scaling
- **CI/CD**: Jenkins pipelines for automated build and deployment

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Ingress Controller                      │
│          (shopnow.<YOUR-USERNAME>.com)                      │
└────┬─────────────────────┬───────────────────┬──────────────┘
     │                     │                   │
     │ /                   │ /admin            │ /api
     │                     │                   │
┌────▼────────┐    ┌──────▼───────┐    ┌─────▼──────┐
│  Frontend   │    │    Admin     │    │  Backend   │
│   (React)   │    │   (React)    │    │  (Node.js) │
│             │    │              │    │            │
│  Port: 80   │    │  Port: 80    │    │ Port: 5000 │
└─────────────┘    └──────────────┘    └─────┬──────┘
                                              │
                                              │
                                       ┌──────▼─────┐
                                       │  MongoDB   │
                                       │ StatefulSet│
                                       │ Port: 27017│
                                       └────────────┘
```

### Component Interaction

1. **Users** → Access via Ingress → Route to Frontend/Admin
2. **Frontend/Admin** → API calls to Backend (proxy via nginx)
3. **Backend** → Database operations on MongoDB
4. **HPA** → Auto-scale pods based on CPU usage

## 💻 Technology Stack

### Application
- **Frontend**: React 18, HTML5, CSS3, JavaScript ES6+
- **Backend**: Node.js 18, Express.js 4.x
- **Database**: MongoDB 6.0
- **Web Server**: nginx (for serving React apps)

### Infrastructure (Core Requirements)
- **Container**: Docker (multi-stage builds)
- **Orchestration**: Kubernetes 1.27+
- **Package Manager**: HELM 3.x
- **CI/CD**: Jenkins (Groovy pipelines)
- **Cloud**: AWS (EKS, ECR, EBS)
- **Monitoring**: Kubernetes Metrics Server

### DevOps Tools
- **Required**: kubectl, helm, docker, aws-cli, git, jenkins
- **Optional**: ArgoCD (GitOps - bonus feature)

## 📦 Prerequisites

### Local Development
- Node.js 18+ and npm
- Docker Desktop
- Git

### Kubernetes Deployment (Required for Assignment)
- AWS Account with:
  - EKS cluster
  - ECR repositories
  - EBS storage (gp3)
- kubectl configured for your cluster
- HELM 3.x installed
- Jenkins server (for CI/CD pipelines)

### Required Tools Installation

```bash
# macOS
brew install kubectl helm awscli

# Linux (Ubuntu/Debian)
sudo snap install kubectl --classic
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
```

## 🚀 Step-by-Step Setup & Deployment

### Step 0: Verify Project Files

**Purpose**: Ensure all required files are present before starting the deployment process.

**Check if all required Dockerfiles exist:**

```bash
# Navigate to project root
cd c:\Users\ghans\project\herovired\shopNow

# Check Dockerfiles exist (PowerShell)
Test-Path backend\Dockerfile
Test-Path frontend\Dockerfile
Test-Path admin\Dockerfile

# All three commands should return "True". If any return "False", the build will fail.
```

**Expected Output:**
```
True
True
True
```

**Expected Files Structure:**
- ✅ `backend/Dockerfile` - Node.js 18 backend container (single-stage build)
- ✅ `frontend/Dockerfile` - React frontend with nginx (multi-stage build: node builder + nginx runtime)
- ✅ `admin/Dockerfile` - React admin dashboard with nginx (multi-stage build: node builder + nginx runtime)

**What These Files Do:**
- **Backend Dockerfile**: Creates a container with Node.js runtime, installs dependencies, and runs the Express server
- **Frontend/Admin Dockerfiles**: First builds React app (compile JSX to static files), then serves with nginx web server

**Troubleshooting:**
- If any Dockerfile is missing, check if you're in the correct directory
- Verify you've cloned/downloaded the complete project

### Step 1: Prerequisites Check

**Purpose**: Install and verify all required tools are properly configured.

#### 1.1: Check Installed Tools

```powershell
# PowerShell - Check if tools are installed
docker --version
kubectl version --client
helm version
aws --version
```

**Expected Output (versions may vary):**
```
Docker version 24.0.6, build ed223bc
Client Version: v1.28.0
version.BuildInfo{Version:"v3.13.0", GitCommit:"825e86f", ...}
aws-cli/2.13.0 Python/3.11.4 Windows/10 exe/AMD64
```

#### 1.2: Install Missing Tools (Windows)

**Option A: Using Chocolatey (Recommended)**
```powershell
# Install Chocolatey first (if not installed)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install tools
choco install docker-desktop -y
choco install kubernetes-cli -y
choco install kubernetes-helm -y
choco install awscli -y

# Restart PowerShell after installation
```

**Option B: Manual Installation**
- **Docker Desktop**: Download from https://www.docker.com/products/docker-desktop/
- **kubectl**: Download from https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
- **HELM**: Download from https://github.com/helm/helm/releases
- **AWS CLI**: Download from https://aws.amazon.com/cli/

#### 1.3: Verify Docker Desktop

```powershell
# Start Docker Desktop (if not running)
# Check Docker is running
docker ps
```

**Expected Output:**
```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
(Empty list is fine - means Docker is running with no containers)

**Troubleshooting:**
- If "docker ps" fails: Open Docker Desktop application and wait for it to start
- Check system tray for Docker icon (should be running, not restarting)

#### 1.4: Configure AWS CLI

```powershell
# Configure AWS credentials
aws configure
```

**You'll be prompted to enter:**
```
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-east-1
Default output format [None]: json
```

**Where to Get AWS Credentials:**
1. Log into AWS Console: https://console.aws.amazon.com/
2. Click your username (top right) → Security credentials
3. Scroll to "Access keys" → Create access key
4. Download and save the credentials securely

#### 1.5: Verify AWS Configuration

```powershell
# Test AWS connection
aws sts get-caller-identity
```

**Expected Output:**
```json
{
    "UserId": "AIDAJEXAMPLEID",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/your-username"
}
```

**What This Means:**
- **Account**: Your 12-digit AWS Account ID (you'll need this for ECR)
- **Arn**: Your IAM user identity
- If this works, your AWS CLI is configured correctly

**Troubleshooting:**
- **Error: "Unable to locate credentials"**: Run `aws configure` again
- **Error: "InvalidClientTokenId"**: Your access key is incorrect
- **Error: "SignatureDoesNotMatch"**: Your secret key is incorrect

### Step 2: Setup EKS Cluster (One-time)

**Purpose**: Create a managed Kubernetes cluster on AWS where your application will run.

**Time Required**: 15-20 minutes (AWS creates cluster infrastructure)

**Cost**: ~$0.10/hour for EKS control plane + ~$0.04/hour per t3.medium node

#### 2.1: Install eksctl (if needed)

```powershell
# Install eksctl using Chocolatey
choco install eksctl -y

# Or download from: https://github.com/weaveworks/eksctl/releases

# Verify installation
eksctl version
```

**Expected Output:**
```
0.167.0
```

#### 2.2: Create EKS Cluster

```powershell
# Set your region (change if needed)
$REGION = "ap-south-1"

# Create cluster (this takes ~15-20 minutes)
eksctl create cluster `
  --name shopnow-eks-cluster `
  --region $REGION `
  --nodegroup-name standard-workers `
  --node-type t3.medium `
  --nodes 2 `
  --nodes-min 1 `
  --nodes-max 3 `
  --managed
```

**What This Command Does:**
- `--name`: Names your cluster "shopnow-eks-cluster"
- `--region`: Creates cluster in us-east-1 (N. Virginia)
- `--node-type t3.medium`: 2 vCPUs, 4 GB RAM per node
- `--nodes 2`: Starts with 2 worker nodes
- `--nodes-min/max`: Auto-scaling limits (1-3 nodes)
- `--managed`: Uses AWS-managed node groups (easier maintenance)

**Expected Output (this will take ~15 minutes):**
<img width="1919" height="1017" alt="image" src="https://github.com/user-attachments/assets/d45fdbb1-9378-461a-b73a-ed7e7cc71ed5" />
<img width="1723" height="443" alt="image" src="https://github.com/user-attachments/assets/be49d46d-1e60-4dff-a265-eb59121bc47b" />
<img width="1554" height="79" alt="image" src="https://github.com/user-attachments/assets/06b2838e-df09-445f-ba00-1e17d6839df1" />

**Alternative: Use Existing Cluster**

If you already have an EKS cluster, skip creation and just configure kubectl:
```powershell
aws eks update-kubeconfig --region ap-south-1 --name your-existing-cluster-name
```

#### 2.3: Configure kubectl

```powershell
# Connect kubectl to your new cluster
aws eks update-kubeconfig --region ap-south-1 --name shopnow-eks-cluster
```

**Expected Output:**
<img width="1315" height="40" alt="image" src="https://github.com/user-attachments/assets/a5e8b8eb-51d8-4e97-b5e1-d590014f37a9" />



**What This Does:**
- Downloads cluster authentication config
- Updates your `~/.kube/config` file
- Sets this cluster as your current context

#### 2.4: Verify Cluster Access

```powershell
# Check cluster information
kubectl cluster-info
```

**Expected Output:**
<img width="1639" height="74" alt="image" src="https://github.com/user-attachments/assets/7ea40122-0002-421f-878c-c382ba5d70b9" />


```powershell
# List worker nodes
kubectl get nodes
```

**Expected Output:**
<img width="1033" height="103" alt="image" src="https://github.com/user-attachments/assets/0b5ac702-86fd-4554-9e5e-ddb0458f8ba7" />


**What This Shows:**
- 2 nodes are running (as configured)
- Both are "Ready" (healthy and accepting workloads)
- Running Kubernetes version 1.28

**Troubleshooting:**
- **Error: "couldn't get current server API group list"**: Wait 1-2 minutes, cluster may still be initializing
- **Error: "No cluster found"**: Check cluster name spelling and region
- **No nodes showing**: Run `eksctl get nodegroup --cluster shopnow-eks-cluster --region us-east-1` to check node status

### Step 3: Create ECR Repositories

**Purpose**: Create private Docker image repositories in AWS Elastic Container Registry (ECR).

**What is ECR?** AWS's managed Docker registry service (like Docker Hub, but private and integrated with AWS).

#### 3.1: Get Your AWS Account Information

```powershell
# PowerShell - Get your AWS Account ID
$AWS_ACCOUNT_ID = aws sts get-caller-identity --query Account --output text
$AWS_REGION = "ap-south-1"

Write-Host "AWS Account ID: $AWS_ACCOUNT_ID" -ForegroundColor Green
Write-Host "AWS Region: $AWS_REGION" -ForegroundColor Green

# Save these values - you'll need them later!
```

**Expected Output:**
```
AWS Account ID: 123456789012
AWS Region: ap-south-1
```

**Important**: Copy your Account ID - you'll need it in Step 4!

#### 3.2: Create ECR Repositories

```powershell
# Create repository for backend images
aws ecr create-repository `
  --repository-name shopnow/backend `
  --region $AWS_REGION `
  --image-scanning-configuration scanOnPush=true

Write-Host "Backend repository created!" -ForegroundColor Green

# Create repository for frontend images
aws ecr create-repository `
  --repository-name shopnow/frontend `
  --region $AWS_REGION `
  --image-scanning-configuration scanOnPush=true

Write-Host "Frontend repository created!" -ForegroundColor Green

# Create repository for admin images
aws ecr create-repository `
  --repository-name shopnow/admin `
  --region $AWS_REGION `
  --image-scanning-configuration scanOnPush=true

Write-Host "Admin repository created!" -ForegroundColor Green
```

**What Each Flag Does:**
- `--repository-name shopnow/backend`: Creates repository at path "shopnow/backend"
- `--image-scanning-configuration scanOnPush=true`: Automatically scan images for vulnerabilities

**Expected Output (per repository):**
<img width="1919" height="993" alt="image" src="https://github.com/user-attachments/assets/5a538755-07c1-4719-8b49-20ed6efda94c" />


**Important**: Note the `repositoryUri` - this is where your Docker images will be pushed.

#### 3.3: Verify Repositories Created

```powershell
# List all ECR repositories
aws ecr describe-repositories --region $AWS_REGION --output table
```

**Expected Output:**
<img width="1197" height="306" alt="image" src="https://github.com/user-attachments/assets/73492c84-66e5-4b93-bd43-b920f1f2a2ff" />


**You should see 3 repositories:**
- ✅ shopnow/backend
- ✅ shopnow/frontend
- ✅ shopnow/admin

#### 3.4: Test ECR Login

```powershell
# Authenticate Docker with ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
```

**Expected Output:**
```
Login Succeeded
```

**What This Does:**
- Gets a temporary password from AWS ECR
- Logs Docker into your ECR registry
- Valid for 12 hours (then you need to re-login)

**Troubleshooting:**
- **Error: "RepositoryAlreadyExistsException"**: Repository already exists (safe to ignore)
- **Error: "AccessDeniedException"**: Your IAM user needs ECR permissions
- **Error: "Error saving credentials"**: Install "Docker Desktop" or configure Docker credential store

### Step 4: Replace Placeholders in Configuration Files

**Purpose**: Update all configuration files with your actual AWS account details and preferred domain.

**Critical**: This step MUST be done before building images or deploying to Kubernetes!

#### 4.1: Identify Your Values

Before replacing, gather these three values:

```powershell
# 1. Get your AWS Account ID (from Step 3)
$ACCOUNT_ID = aws sts get-caller-identity --query Account --output text
Write-Host "AWS Account ID: $ACCOUNT_ID"

# 2. Your AWS Region (should match Step 2)
$REGION = "ap-south-1"
Write-Host "AWS Region: $REGION"

# 3. Choose a unique username/identifier
$USERNAME = "ghanshyam"  # Change this to your name or identifier
Write-Host "Username: $USERNAME"
```

**Example Values:**
- ACCOUNT_ID: `123456789012` (your actual AWS account ID)
- REGION: `us-east-1` (where you created EKS cluster)
- USERNAME: `john-doe` (used for domain name: shopnow.john-doe.com)

#### 4.2: Option A - Using VS Code Find & Replace (Recommended for Beginners)

**Step-by-Step Instructions:**

1. **Open VS Code** in your project folder

2. **Open Find and Replace**:
   - Press `Ctrl+Shift+H` (Windows/Linux) or `Cmd+Shift+H` (Mac)
   - This opens the "Find in Files" sidebar

3. **Replace AWS Account ID**:
   - Find: `<ACCOUNT-ID>`
   - Replace: `123456789012` (your actual account ID)
   - Click "Replace All" (button with double arrows)
   - Confirm the number of replacements (should see ~30-40 replacements)

4. **Replace AWS Region**:
   - Find: `<REGION>`
   - Replace: `ap-south-1` (your actual region)
   - Click "Replace All"
   - Confirm replacements (should see ~40-50 replacements)

5. **Replace Username**:
   - Find: `<YOUR-USERNAME>`
   - Replace: `ghanshyam` (your chosen identifier)
   - Click "Replace All"
   - Confirm replacements (should see ~10-15 replacements)

6. **Verify Changes**:
   - Press `Ctrl+Shift+F` to search for `<ACCOUNT-ID>`
   - Should find 0 results (all replaced)
   - Repeat for `<REGION>` and `<YOUR-USERNAME>`

**Files That Will Be Updated:**
- All HELM charts in `kubernetes/helm/charts/*/values.yaml`
- All Kubernetes manifests in `kubernetes/k8s-manifests/`
- All Jenkins pipelines in `jenkins/Jenkinsfile.*`
- ArgoCD applications in `kubernetes/argocd/`
- Build script in `scripts/build-and-push.sh`

#### 4.3: Option B - Automated PowerShell Script

**For those comfortable with scripting:**

```powershell
# Navigate to project root
cd c:\Users\ghans\project\herovired\shopNow

# Set your values (CHANGE THESE!)
$ACCOUNT_ID = "123456789012"  # Your AWS Account ID from Step 3
$REGION = "ap-south-1"          # Your AWS Region
$USERNAME = "ghanshyam"         # Your chosen username

# Display values for confirmation
Write-Host "`nValues to be replaced:" -ForegroundColor Yellow
Write-Host "  <ACCOUNT-ID>      → $ACCOUNT_ID" -ForegroundColor Cyan
Write-Host "  <REGION>          → $REGION" -ForegroundColor Cyan
Write-Host "  <YOUR-USERNAME>   → $USERNAME" -ForegroundColor Cyan
Write-Host ""

# Ask for confirmation
$confirmation = Read-Host "Proceed with replacement? (yes/no)"

if ($confirmation -eq "yes") {
    # Find and replace in all relevant files
    $fileTypes = @("*.yaml", "*.yml", "*Jenkinsfile*", "*.sh", "*.md")
    $counter = 0
    
    Get-ChildItem -Recurse -Include $fileTypes | ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        $originalContent = $content
        
        # Perform replacements
        $content = $content -replace '<ACCOUNT-ID>', $ACCOUNT_ID
        $content = $content -replace '<REGION>', $REGION
        $content = $content -replace '<YOUR-USERNAME>', $USERNAME
        
        # Only write if content changed
        if ($content -ne $originalContent) {
            Set-Content $_.FullName -Value $content -NoNewline
            $counter++
            Write-Host "Updated: $($_.FullName)" -ForegroundColor Green
        }
    }
    
    Write-Host "`n✅ Success! Replaced placeholders in $counter files" -ForegroundColor Green
    
    # Verify no placeholders remain
    Write-Host "`nVerifying replacements..." -ForegroundColor Yellow
    $remaining = Get-ChildItem -Recurse -Include $fileTypes | 
        Select-String -Pattern "<ACCOUNT-ID>|<REGION>|<YOUR-USERNAME>"
    
    if ($remaining) {
        Write-Host "⚠️  Warning: Some placeholders still remain:" -ForegroundColor Red
        $remaining | ForEach-Object { Write-Host "  $($_.Filename):$($_.LineNumber)" }
    } else {
        Write-Host "✅ All placeholders replaced successfully!" -ForegroundColor Green
    }
} else {
    Write-Host "Replacement cancelled." -ForegroundColor Red
}
```

**Expected Output:**
```
Values to be replaced:
  <ACCOUNT-ID>      → 123456789012
  <REGION>          → ap-south-1
  <YOUR-USERNAME>   → ghanshyam

Proceed with replacement? (yes/no): yes

Updated: kubernetes\helm\charts\backend\values.yaml
Updated: kubernetes\helm\charts\frontend\values.yaml
...
✅ Success! Replaced placeholders in 45 files

Verifying replacements...
✅ All placeholders replaced successfully!
```

#### 4.4: Verify Replacements

**Check a few key files manually:**

```powershell
# Check backend HELM values
cat kubernetes\helm\charts\backend\values.yaml | Select-String -Pattern "123456789012"

# Should show lines like:
# repository: 123456789012.dkr.ecr.us-east-1.amazonaws.com/shopnow/backend
```

```powershell
# Check Ingress for domain
cat kubernetes\k8s-manifests\ingress\ingress-shopnow.yaml | Select-String -Pattern "shopnow"

# Should show:
# host: shopnow.john-doe.com
```

```powershell
# Search for any remaining placeholders
Get-ChildItem -Recurse -Include *.yaml,*.yml | Select-String -Pattern "<ACCOUNT-ID>|<REGION>|<YOUR-USERNAME>"

# Should return NO results (empty output)
```

**Troubleshooting:**
- **Still seeing placeholders**: Run the replacement script again or use VS Code Find & Replace
- **Wrong values replaced**: Use Git to reset files: `git checkout .` then re-run replacement
- **Script execution disabled**: Run `Set-ExecutionPolicy -Scope Process -Force RemoteSigned` in PowerShell

### Step 5: Build & Push Docker Images

**Purpose**: Build Docker containers for all three components and push them to AWS ECR.

**Time Required**: 10-15 minutes (depends on internet speed)

#### 5.1: Login to ECR (Required Before Push)

```powershell
# Navigate to project root
cd c:\Users\ghans\project\herovired\shopNow

# Get your AWS credentials
$AWS_ACCOUNT_ID = aws sts get-caller-identity --query Account --output text
$AWS_REGION = "ap-south-1"

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
```

**Expected Output:**
```
Login Succeeded
```

#### 5.2: Build Images Manually (Option A - Recommended for Learning)

**Build Backend Image:**
```powershell
Write-Host "Building Backend Image..." -ForegroundColor Yellow

# Build image
docker build -t shopnow/backend:latest ./backend

# Tag for ECR
docker tag shopnow/backend:latest "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/backend:latest"

# Push to ECR
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/backend:latest"

Write-Host "✅ Backend image pushed successfully!" -ForegroundColor Green
```

**What Each Command Does:**
- `docker build`: Reads `backend/Dockerfile` and creates image
- `docker tag`: Adds ECR registry URL to image name
- `docker push`: Uploads image to AWS ECR

**Expected Output:**
<img width="1609" height="787" alt="image" src="https://github.com/user-attachments/assets/fae4d29c-b37f-493f-87a2-22864e724a07" />


**Build Frontend Image:**
```powershell
Write-Host "Building Frontend Image..." -ForegroundColor Yellow

# Build image (multi-stage build takes longer)
docker build -t shopnow/frontend:latest ./frontend

# Tag for ECR
docker tag shopnow/frontend:latest "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/frontend:latest"

# Push to ECR
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/frontend:latest"

Write-Host "✅ Frontend image pushed successfully!" -ForegroundColor Green
```

**Excepted Output**
<img width="1919" height="1006" alt="image" src="https://github.com/user-attachments/assets/d6a6f388-1bf4-49d7-86c3-1b817f37a5de" />
<img width="1913" height="809" alt="image" src="https://github.com/user-attachments/assets/9d26c269-2619-4d49-aa61-dd1e95e85f3d" />


**Build Admin Image:**
```powershell
Write-Host "Building Admin Image..." -ForegroundColor Yellow

# Build image
docker build -t shopnow/admin:latest ./admin

# Tag for ECR
docker tag shopnow/admin:latest "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/admin:latest"

# Push to ECR
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/admin:latest"

Write-Host "✅ Admin image pushed successfully!" -ForegroundColor Green
```
**Excepted Output**
<img width="1631" height="584" alt="image" src="https://github.com/user-attachments/assets/1e460c3c-caa4-4284-aba8-986ed62e133f" />
<img width="1712" height="313" alt="image" src="https://github.com/user-attachments/assets/8b105648-192c-4048-bf66-c8abc576dde5" />

#### 5.3: Using Automated Script (Option B - Faster)

**For Bash (Git Bash on Windows/Linux/Mac):**
```bash
# Make script executable
chmod +x scripts/build-and-push.sh

# Set environment variables
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_REGION="us-east-1"

# Build and push all images
./scripts/build-and-push.sh all latest
```

**PowerShell Alternative (if bash script fails):**
```powershell
# Build all images sequentially
$components = @("backend", "frontend", "admin")

foreach ($component in $components) {
    Write-Host "`nBuilding $component..." -ForegroundColor Yellow
    
    docker build -t "shopnow/$component:latest" "./$component"
    docker tag "shopnow/$component:latest" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/$component:latest"
    docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/shopnow/$component:latest"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ $component completed!" -ForegroundColor Green
    } else {
        Write-Host "❌ $component failed!" -ForegroundColor Red
        break
    }
}
```

#### 5.4: Verify Images in ECR

```powershell
# Check backend images
aws ecr describe-images --repository-name shopnow/backend --region $AWS_REGION

# Check frontend images
aws ecr describe-images --repository-name shopnow/frontend --region $AWS_REGION

# Check admin images
aws ecr describe-images --repository-name shopnow/admin --region $AWS_REGION
```

**Expected Output (per repository):**
<img width="1919" height="1007" alt="image" src="https://github.com/user-attachments/assets/12c1dc5c-2faf-42c0-b77e-429be6785aaa" />
<img width="1919" height="1007" alt="image" src="https://github.com/user-attachments/assets/97e011e8-eb99-495a-8adf-0d111b40cea9" />
<img width="1919" height="750" alt="image" src="https://github.com/user-attachments/assets/25bee06f-29b3-412e-bae5-985e29f73a79" />

**Quick Verification:**
```powershell
# List all images across all repositories
aws ecr describe-repositories --region $AWS_REGION --query 'repositories[?contains(repositoryName, `shopnow`)].repositoryName' --output table
```

**Expected: 3 repositories with images:**
- ✅ shopnow/backend (tag: latest)
- ✅ shopnow/frontend (tag: latest)
- ✅ shopnow/admin (tag: latest)

**ScreenShot**
<img width="1914" height="241" alt="image" src="https://github.com/user-attachments/assets/d662f992-f135-428e-a00e-0611ebcac56f" />


#### 5.5: View Image Sizes

```powershell
Write-Host "`nImage Sizes:" -ForegroundColor Cyan

$repos = @("shopnow/backend", "shopnow/frontend", "shopnow/admin")
foreach ($repo in $repos) {
    $size = aws ecr describe-images --repository-name $repo --region $AWS_REGION --query 'imageDetails[0].imageSizeInBytes' --output text
    $sizeMB = [math]::Round($size / 1MB, 2)
    Write-Host "  $repo : $sizeMB MB"
}
```

**Expected Sizes:**
- Backend: ~150-200 MB (Node.js + dependencies)
- Frontend: ~40-60 MB (nginx + static files)
- Admin: ~40-60 MB (nginx + static files)

**Troubleshooting:**
- **Error: "no such file or directory"**: Check you're in project root directory
- **Error: "denied: Your authorization token has expired"**: Re-run ECR login (Step 5.1)
- **Error: "Cannot connect to Docker daemon"**: Start Docker Desktop
- **Error: "COPY failed"**: Missing files in Dockerfile context (check .dockerignore)
- **Build very slow**: Multi-stage builds (frontend/admin) compile React - wait 3-5 minutes per image

### Step 6: Deploy to Kubernetes

**Purpose**: Deploy all application components to your EKS cluster using HELM charts.

**Time Required**: 10-15 minutes (includes waiting for pods to start)

**Deployment Order (Important!):**
1. Prerequisites (namespace, storage, metrics)
2. MongoDB (database must be ready first)
3. Backend (API needs database connection)
4. Frontend & Admin (UI applications)
5. Ingress (routing rules)

---

#### Option A: Using HELM Charts (Recommended)

**6.1: Install Prerequisites**

**6.1.1: Create Namespace**
```powershell
Write-Host "Step 6.1.1: Creating namespace..." -ForegroundColor Yellow

# Create namespace
kubectl apply -f kubernetes/k8s-manifests/namespace/namespace.yaml

# Wait a moment for namespace to be created
Start-Sleep -Seconds 2

# Verify namespace exists
kubectl get namespace shopnow-demo
```

**Expected Output:**
<img width="1261" height="143" alt="image" src="https://github.com/user-attachments/assets/294f46ec-ffb5-4cb6-8915-038f2dcd7faf" />


**What This Does:**
- Creates isolated workspace called "shopnow-demo"
- All application resources will be deployed here
- Allows easy cleanup (delete namespace = delete everything)

**6.1.2: Install Storage Class**
```powershell
Write-Host "Step 6.1.2: Installing AWS EBS gp3 storage class..." -ForegroundColor Yellow

kubectl apply -f kubernetes/pre-req/storageclass-gp3.yaml

# Verify storage class
kubectl get storageclass gp3-ssd
```

**Expected Output:**
<img width="1123" height="138" alt="image" src="https://github.com/user-attachments/assets/2b47c1a4-18be-489a-a59c-1e39cb90a986" />


**What This Does:**
- Configures AWS EBS gp3 SSD volumes (faster than gp2)
- MongoDB will use this for persistent storage
- WaitForFirstConsumer: Volume created when pod scheduled

**6.1.3: Install Metrics Server**
```powershell
Write-Host "Step 6.1.3: Installing Metrics Server..." -ForegroundColor Yellow

kubectl apply -f kubernetes/pre-req/metrics-server.yaml

# Wait for metrics server to be ready (important for HPA!)
Write-Host "Waiting for Metrics Server to be ready..." -ForegroundColor Cyan
kubectl wait --for=condition=ready pod -l k8s-app=metrics-server -n kube-system --timeout=120s

# Verify metrics server is working
kubectl top nodes
```

**Expected Output:**
<img width="1658" height="447" alt="image" src="https://github.com/user-attachments/assets/e2e27941-2c52-4da2-853d-a52ca87ef926" />


**What This Does:**
- Collects CPU/memory metrics from nodes and pods
- Required for Horizontal Pod Autoscaler (HPA) to work
- Enables `kubectl top` commands

---

# Delete the EKS addon version
aws eks delete-addon `
  --cluster-name $CLUSTER_NAME `
  --addon-name aws-ebs-csi-driver `
  --region $AWS_REGION

Start-Sleep -Seconds 30

# Install using kubectl (more reliable)
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.25"

# Verify installation
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver

<img width="1907" height="924" alt="image" src="https://github.com/user-attachments/assets/c34e9b99-b564-45da-acb2-14aa7e5287b4" />
<img width="1793" height="929" alt="image" src="https://github.com/user-attachments/assets/0bbe80ae-34c1-4e18-ac7f-fe5e6d81ccd7" />



**6.2: Deploy MongoDB (Database Layer)**

```powershell
Write-Host "`nStep 6.2: Deploying MongoDB..." -ForegroundColor Yellow

# Install MongoDB using HELM
helm install mongo kubernetes/helm/charts/mongo -n shopnow-demo

# Wait for MongoDB StatefulSet to be ready
Write-Host "Waiting for MongoDB to be ready (this may take 2-3 minutes)..." -ForegroundColor Cyan
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=mongo -n shopnow-demo --timeout=300s

# Verify MongoDB deployment
Write-Host "`nMongoDB Status:" -ForegroundColor Green
kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=mongo
kubectl get pvc -n shopnow-demo
kubectl get svc -n shopnow-demo -l app.kubernetes.io/name=mongo
```

**Expected Output:**
<img width="1538" height="160" alt="image" src="https://github.com/user-attachments/assets/6602921f-1a68-4e90-881c-2f187bc68a31" />
<img width="1860" height="384" alt="image" src="https://github.com/user-attachments/assets/1a9fc8c5-2403-419e-b082-1fbfd4048a56" />


**What This Shows:**
- ✅ Pod `mongo-0` is Running (1/1 ready)
- ✅ PVC bound to 5Gi EBS volume
- ✅ Headless service for StatefulSet networking

**Check MongoDB Logs:**
```powershell
kubectl logs -f mongo-0 -n shopnow-demo --tail=20
```

**Expected in logs:**
<img width="1913" height="756" alt="image" src="https://github.com/user-attachments/assets/5d5e92ee-b3a8-472d-babd-00540c33f1dc" />


---

**6.3: Deploy Backend (API Layer)**

```powershell
Write-Host "`nStep 6.3: Deploying Backend API..." -ForegroundColor Yellow

# Install Backend using HELM
helm install backend kubernetes/helm/charts/backend -n shopnow-demo

# Wait for backend deployment
Write-Host "Waiting for Backend to be ready..." -ForegroundColor Cyan
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=backend -n shopnow-demo --timeout=180s

# Verify backend deployment
Write-Host "`nBackend Status:" -ForegroundColor Green
kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=backend
kubectl get svc -n shopnow-demo -l app.kubernetes.io/name=backend

# Check backend logs (should show successful MongoDB connection)
Write-Host "`nBackend Logs:" -ForegroundColor Cyan
kubectl logs -n shopnow-demo -l app.kubernetes.io/name=backend --tail=30
```

**Expected Output:**
```
NAME: backend
STATUS: deployed

pod/backend-xxxxx condition met

NAME                      READY   STATUS    RESTARTS   AGE
backend-xxxxxxxxxx-xxxxx  1/1     Running   0          45s

NAME      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
backend   ClusterIP   10.100.123.45   <none>        5000/TCP   45s

--- Backend Logs ---
Server is running on port 5000
Connected to MongoDB successfully
Ready to accept requests
```
<img width="1905" height="623" alt="image" src="https://github.com/user-attachments/assets/47a02a5f-7311-4806-9df3-883fd7751d29" />
<img width="1874" height="77" alt="image" src="https://github.com/user-attachments/assets/cd2e0bb6-f6a4-4d2a-91be-cbabea6a4590" />
<img width="1476" height="99" alt="image" src="https://github.com/user-attachments/assets/13493665-c7cc-4f99-9a35-b1037a309a3f" />
<img width="1736" height="101" alt="image" src="https://github.com/user-attachments/assets/ae1e7af9-5a30-4cca-9db5-dd5ebae557a7" />
<img width="1644" height="174" alt="image" src="https://github.com/user-attachments/assets/2ed21374-0687-49c7-845f-f57184b9bc1b" />


**What This Shows:**
- ✅ Backend pod running
- ✅ Connected to MongoDB
- ✅ ClusterIP service on port 5000

**Test Backend Health:**
```powershell
# Port-forward to test locally
Start-Job -ScriptBlock { kubectl port-forward -n shopnow-demo svc/backend 5000:5000 }
Start-Sleep -Seconds 3

# Test health endpoint
curl http://localhost:5000/api/health

# Stop port-forward
Stop-Job -Name Job1
```

**Expected Response:**
```json
{"status":"ok","database":"connected"}
```
<img width="1910" height="768" alt="image" src="https://github.com/user-attachments/assets/6b8c7c0c-0c17-44fd-b44d-ca850a9ee127" />

---

**6.4: Deploy Frontend (Customer UI)**

```powershell
Write-Host "`nStep 6.4: Deploying Frontend..." -ForegroundColor Yellow

# Install Frontend using HELM
helm install frontend kubernetes/helm/charts/frontend -n shopnow-demo

# Wait for frontend deployment
Write-Host "Waiting for Frontend to be ready..." -ForegroundColor Cyan
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=frontend -n shopnow-demo --timeout=180s

# Verify frontend deployment
Write-Host "`nFrontend Status:" -ForegroundColor Green
kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=frontend
kubectl get svc -n shopnow-demo -l app.kubernetes.io/name=frontend
```

**Expected Output:**
```
NAME: frontend
STATUS: deployed

NAME                       READY   STATUS    RESTARTS   AGE
frontend-xxxxxxxxxx-xxxxx  1/1     Running   0          30s

NAME       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
frontend   ClusterIP   10.100.234.56   <none>        80/TCP    30s
```
<img width="1698" height="212" alt="image" src="https://github.com/user-attachments/assets/06d5d5a1-a2e4-4aec-9b1b-38df2534ba3a" />
<img width="1913" height="95" alt="image" src="https://github.com/user-attachments/assets/d301756e-cbd2-4837-bae7-a12bfee6a2fe" />
<img width="1848" height="219" alt="image" src="https://github.com/user-attachments/assets/4a44d369-a533-4b9f-91a1-6edf8a80ce40" />

---

**6.5: Deploy Admin (Admin Dashboard)**

```powershell
Write-Host "`nStep 6.5: Deploying Admin Dashboard..." -ForegroundColor Yellow

# Install Admin using HELM
helm install admin kubernetes/helm/charts/admin -n shopnow-demo

# Wait for admin deployment
Write-Host "Waiting for Admin to be ready..." -ForegroundColor Cyan
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=admin -n shopnow-demo --timeout=180s

# Verify admin deployment
Write-Host "`nAdmin Status:" -ForegroundColor Green
kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=admin
kubectl get svc -n shopnow-demo -l app.kubernetes.io/name=admin
```

**Expected Output:**
```
NAME: admin
STATUS: deployed

NAME                    READY   STATUS    RESTARTS   AGE
admin-xxxxxxxxxx-xxxxx  1/1     Running   0          30s

NAME    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
admin   ClusterIP   10.100.345.67   <none>        80/TCP    30s
```
<img width="1915" height="451" alt="image" src="https://github.com/user-attachments/assets/e0d47b51-2c7e-4c39-afe6-4ff3b3ee16ee" />

---

**6.6: Setup Ingress (Routing Layer)**

**6.6.1: Install NGINX Ingress Controller**
```powershell
Write-Host "`nStep 6.6.1: Installing NGINX Ingress Controller..." -ForegroundColor Yellow

# Check if already installed
$existing = kubectl get namespace ingress-nginx 2>$null

if (-not $existing) {
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/aws/deploy.yaml
    
    Write-Host "Waiting for Ingress Controller to be ready (2-3 minutes)..." -ForegroundColor Cyan
    kubectl wait --namespace ingress-nginx `
      --for=condition=ready pod `
      --selector=app.kubernetes.io/component=controller `
      --timeout=300s
} else {
    Write-Host "Ingress Controller already installed" -ForegroundColor Green
}

# Verify ingress controller
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```

**Expected Output:**
```
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
...

pod/ingress-nginx-controller-xxxxx condition met

NAME                                 READY   STATUS    AGE
ingress-nginx-controller-xxxxx       1/1     Running   2m

NAME                                 TYPE           EXTERNAL-IP                                                              PORT(S)
ingress-nginx-controller             LoadBalancer   a1b2c3-123456789.us-east-1.elb.amazonaws.com                            80:31234/TCP,443:31235/TCP
```
<img width="1918" height="1017" alt="image" src="https://github.com/user-attachments/assets/6eba51d0-fe0a-4934-886f-94d39d8262ae" />
<img width="1903" height="436" alt="image" src="https://github.com/user-attachments/assets/8191ea98-1ba8-4144-b125-9e5951c606ce" />


**Important**: Note the EXTERNAL-IP (AWS LoadBalancer DNS) - you'll use this to access your application!

**6.6.2: Apply Ingress Rules**
```powershell
Write-Host "`nStep 6.6.2: Applying Ingress rules..." -ForegroundColor Yellow

kubectl apply -f kubernetes/k8s-manifests/ingress/ingress-shopnow.yaml

# Wait for ingress to get address
Write-Host "Waiting for Ingress address..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

# Get Ingress details
kubectl get ingress -n shopnow-demo
kubectl describe ingress shopnow-ingress -n shopnow-demo
```

**Expected Output:**
```
ingress.networking.k8s.io/shopnow-ingress created

NAME              CLASS   HOSTS                   ADDRESS                                          PORTS   AGE
shopnow-ingress   nginx   shopnow.john-doe.com    a1b2c3-123456789.us-east-1.elb.amazonaws.com    80      15s

Rules:
  Host                   Path  Backends
  ----                   ----  --------
  shopnow.john-doe.com
                         /              frontend:80 (10.0.1.5:80)
                         /admin         admin:80 (10.0.1.6:80)
                         /api           backend:5000 (10.0.1.7:5000)
```

<img width="1774" height="686" alt="image" src="https://github.com/user-attachments/assets/f4266b50-a3f0-41b8-a8a0-b8220d7be8a4" />


**What This Shows:**
- ✅ Ingress routes configured:
  - `/ghanshyam` → Frontend
  - `/ghanshyam-admin` → Admin Dashboard
  - `/ghanshyam/api` → Backend API

---

### Step 7: Verify Deployment

**Purpose**: Confirm all components are running correctly and communicating properly.

#### 7.1: Check All Resources

```powershell
Write-Host "=== ShopNow Deployment Status ===" -ForegroundColor Cyan

# Get all resources in namespace
kubectl get all -n shopnow-demo
```

**Expected Output:**
```
NAME                           READY   STATUS    RESTARTS   AGE
pod/admin-xxx                  1/1     Running   0          5m
pod/backend-xxx                1/1     Running   0          8m
pod/frontend-xxx               1/1     Running   0          5m
pod/mongo-0                    1/1     Running   0          10m

NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
service/admin     ClusterIP   10.100.200.50    <none>        80/TCP      5m
service/backend   ClusterIP   10.100.100.100   <none>        5000/TCP    8m
service/frontend  ClusterIP   10.100.150.75    <none>        80/TCP      5m
service/mongo     ClusterIP   None             <none>        27017/TCP   10m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/admin      1/1     1            1           5m
deployment.apps/backend    1/1     1            1           8m
deployment.apps/frontend   1/1     1            1           5m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/admin-xxx             1         1         1       5m
replicaset.apps/backend-xxx           1         1         1       8m
replicaset.apps/frontend-xxx          1         1         1       5m

NAME                     READY   AGE
statefulset.apps/mongo   1/1     10m
```
<img width="1913" height="703" alt="image" src="https://github.com/user-attachments/assets/af0db0bf-440c-46e6-9400-0e6282e9cf44" />


**Health Check Indicators:**
- ✅ All pods show `1/1 READY`
- ✅ All pods in `Running` STATUS
- ✅ RESTARTS should be 0 (or very low)
- ✅ All deployments `AVAILABLE = 1`

#### 7.2: Detailed Pod Status

```powershell
Write-Host "`n=== Pod Details ===" -ForegroundColor Cyan
kubectl get pods -n shopnow-demo -o wide
```

**Expected Output:**
```
NAME           READY   STATUS    RESTARTS   AGE   IP          NODE
admin-xxx      1/1     Running   0          5m    10.0.2.10   ip-192-168-10-20
backend-xxx    1/1     Running   0          8m    10.0.1.15   ip-192-168-10-20
frontend-xxx   1/1     Running   0          5m    10.0.2.20   ip-192-168-20-30
mongo-0        1/1     Running   0          10m   10.0.1.5    ip-192-168-10-20
```
<img width="1911" height="214" alt="image" src="https://github.com/user-attachments/assets/3fd79ebd-1f60-411e-a564-fd4b31911ddf" />


**What to Verify:**
- Each pod has an internal IP address
- Pods distributed across nodes (better availability)
- Ages make sense (mongo oldest, backend next, then frontend/admin)

#### 7.3: Check Services

```powershell
Write-Host "`n=== Services ===" -ForegroundColor Cyan
kubectl get svc -n shopnow-demo
```

**Expected Output:**
```
NAME       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
admin      ClusterIP   10.100.200.50    <none>        80/TCP      5m
backend    ClusterIP   10.100.100.100   <none>        5000/TCP    8m
frontend   ClusterIP   10.100.150.75    <none>        80/TCP      5m
mongo      ClusterIP   None             <none>        27017/TCP   10m
```
<img width="1555" height="180" alt="image" src="https://github.com/user-attachments/assets/8cc23052-6d0f-4bc6-b07c-0e196990a963" />

**Service Types:**
- **ClusterIP (frontend, backend, admin)**: Internal access only (via Ingress)
- **Headless (mongo)**: Direct pod-to-pod communication for StatefulSet

#### 7.4: Check Ingress Configuration

```powershell
Write-Host "`n=== Ingress Configuration ===" -ForegroundColor Cyan
kubectl get ingress -n shopnow-demo
```

**Expected Output:**
```
NAME              CLASS   HOSTS                   ADDRESS                                          PORTS   AGE
shopnow-ingress   nginx   shopnow.john-doe.com    a1b2c3-123.us-east-1.elb.amazonaws.com          80      3m
```
<img width="1807" height="88" alt="image" src="https://github.com/user-attachments/assets/92689df1-195d-4ce1-a4b6-6f11bd8ce60b" />

**Detailed Ingress Info:**
```powershell
kubectl describe ingress shopnow-ingress -n shopnow-demo
```

**Expected Output:**
```
Name:             shopnow-ingress
Namespace:        shopnow-demo
Address:          a1b2c3-123.us-east-1.elb.amazonaws.com
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
Rules:
  Host                   Path  Backends
  ----                   ----  --------
  shopnow.john-doe.com
                         /              frontend:80 (10.0.2.20:80)
                         /admin         admin:80 (10.0.2.10:80)
                         /api           backend:5000 (10.0.1.15:5000)
Annotations:
  nginx.ingress.kubernetes.io/rewrite-target: /
Events:
  Type    Reason  Message
  ----    ------  -------
  Normal  Sync    Scheduled for sync
```
<img width="1866" height="465" alt="image" src="https://github.com/user-attachments/assets/09876d39-c396-4e8b-8229-daa9ed0da246" />

**Important**: Copy the ADDRESS (AWS LoadBalancer URL) - you'll use this to access the app!

#### 7.5: Check Horizontal Pod Autoscaler (HPA)

```powershell
Write-Host "`n=== Horizontal Pod Autoscalers ===" -ForegroundColor Cyan
kubectl get hpa -n shopnow-demo
```

**Expected Output:**
```
NAME       REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
admin      Deployment/admin      15%/80%   1         3         1          5m
backend    Deployment/backend    20%/80%   1         3         1          8m
frontend   Deployment/frontend   10%/80%   1         3         1          5m
```
<img width="1374" height="147" alt="image" src="https://github.com/user-attachments/assets/540a01a5-7718-4879-bab8-51eb75edf805" />

**What This Shows:**
- **TARGETS**: Current CPU usage / Target threshold
- **MINPODS**: Minimum replicas (1)
- **MAXPODS**: Maximum replicas (3)
- **REPLICAS**: Current number of pods

**Note**: If TARGETS shows `<unknown>`, wait 1-2 minutes for metrics to populate.

#### 7.6: Check Persistent Volumes (Database Storage)

```powershell
Write-Host "`n=== Persistent Storage ===" -ForegroundColor Cyan
kubectl get pv,pvc -n shopnow-demo
```

**Expected Output:**
```
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM
persistentvolume/pvc-abc-123               5Gi        RWO            Delete           Bound    shopnow-demo/data-mongo-0

NAME                                STATUS   VOLUME        CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/data-mongo-0  Bound    pvc-abc-123   5Gi        RWO            gp3-ssd        10m
```
<img width="1909" height="296" alt="image" src="https://github.com/user-attachments/assets/82ee3260-2b1f-41b8-9d9e-ff5fb38e822e" />

**What This Shows:**
- ✅ PVC `data-mongo-0` is Bound to a PV
- ✅ 5Gi storage allocated
- ✅ Using gp3-ssd storage class (fast SSD)

#### 7.7: View Component Logs

**MongoDB Logs:**
```powershell
Write-Host "`n=== MongoDB Logs ===" -ForegroundColor Cyan
kubectl logs -n shopnow-demo mongo-0 --tail=20
```

**Expected:**
```
Waiting for connections on port 27017
{"t":{"$date":"..."},"s":"I", "c":"NETWORK", "msg":"Listening on", "attr":{"address":"0.0.0.0"}}
```
<img width="1905" height="512" alt="image" src="https://github.com/user-attachments/assets/86b0fd7e-c2ad-40e3-957e-50e8b642627b" />


**Backend Logs:**
```powershell
Write-Host "`n=== Backend Logs ===" -ForegroundColor Cyan
kubectl logs -n shopnow-demo -l app.kubernetes.io/name=backend --tail=30
```

**Expected:**
```
Server is running on port 5000
Connected to MongoDB: mongodb://mongo:27017/shopnow
Database connection established
Express app listening on port 5000
```
<img width="1591" height="169" alt="image" src="https://github.com/user-attachments/assets/b11c8e76-21ed-4795-b21d-4ee376e82863" />


**Frontend Logs:**
```powershell
Write-Host "`n=== Frontend Logs ===" -ForegroundColor Cyan
kubectl logs -n shopnow-demo -l app.kubernetes.io/name=frontend --tail=20
```

**Expected (nginx logs):**
```
/docker-entrypoint.sh: Configuration complete; ready for start up
```
<img width="1468" height="482" alt="image" src="https://github.com/user-attachments/assets/52f6efb2-29cb-46b9-b2de-371c163cf014" />

#### 7.8: Check Events (Troubleshooting)

```powershell
Write-Host "`n=== Recent Events ===" -ForegroundColor Cyan
kubectl get events -n shopnow-demo --sort-by='.lastTimestamp' | Select-Object -Last 20
```

**Expected (healthy events):**
```
LAST SEEN   TYPE     REASON              OBJECT                  MESSAGE
2m          Normal   Scheduled           pod/backend-xxx         Successfully assigned
2m          Normal   Pulled              pod/backend-xxx         Container image pulled
2m          Normal   Created             pod/backend-xxx         Created container
2m          Normal   Started             pod/backend-xxx         Started container
```
<img width="1908" height="728" alt="image" src="https://github.com/user-attachments/assets/53e1c0ed-c246-4af3-b00d-c22e2c0287c9" />


**Warning Signs (if you see these, there's an issue):**
- `FailedScheduling`: Insufficient resources
- `ImagePullBackOff`: Can't pull Docker image from ECR
- `CrashLoopBackOff`: Container keeps crashing
- `FailedMount`: PVC mounting issues

#### 7.9: Health Check Summary

```powershell
Write-Host "`n=== DEPLOYMENT HEALTH SUMMARY ===" -ForegroundColor Green

# Count running pods
$totalPods = (kubectl get pods -n shopnow-demo --no-headers | Measure-Object).Count
$runningPods = (kubectl get pods -n shopnow-demo --field-selector=status.phase=Running --no-headers | Measure-Object).Count

Write-Host "Total Pods: $totalPods"
Write-Host "Running Pods: $runningPods"

if ($runningPods -eq $totalPods -and $totalPods -ge 4) {
    Write-Host "`n✅ ALL SYSTEMS OPERATIONAL!" -ForegroundColor Green
    Write-Host "Your application is ready to use." -ForegroundColor Green
} else {
    Write-Host "`n⚠️  SOME PODS NOT RUNNING" -ForegroundColor Yellow
    Write-Host "Check pod status and logs for issues." -ForegroundColor Yellow
}
```

**Expected Output:**
```
=== DEPLOYMENT HEALTH SUMMARY ===
Total Pods: 4
Running Pods: 4

✅ ALL SYSTEMS OPERATIONAL!
Your application is ready to use.
```
<img width="1908" height="409" alt="image" src="https://github.com/user-attachments/assets/37b2a79b-a216-4269-8831-be6de068c9fc" />


### Step 8: Access the Application

**Purpose**: Learn different methods to access your deployed application.

#### Method 1: Using Ingress with LoadBalancer (Production Method)

**8.1.1: Get LoadBalancer Address**
```powershell
# Get the Ingress LoadBalancer URL
$INGRESS_ADDRESS = kubectl get ingress shopnow-ingress -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

Write-Host "LoadBalancer URL: $INGRESS_ADDRESS" -ForegroundColor Green
Write-Host "`nAccess your application at:" -ForegroundColor Cyan
Write-Host "  Frontend:  http://$INGRESS_ADDRESS" -ForegroundColor Yellow
Write-Host "  Admin:     http://$INGRESS_ADDRESS/ghanshyam-admin" -ForegroundColor Yellow
Write-Host "  API:       http://$INGRESS_ADDRESS/ghanshyam/api/" -ForegroundColor Yellow
```

**Expected Output:**
```
LoadBalancer URL: a1b2c3-123456789.us-east-1.elb.amazonaws.com

Access your application at:
  Frontend:  http://a1b2c3-123456789.us-east-1.elb.amazonaws.com
  Admin:     http://a1b2c3-123456789.us-east-1.elb.amazonaws.com/ghanshyam/admin
  API:       http://a1b2c3-123456789.us-east-1.elb.amazonaws.com/ghanshyam-api/
```

**8.1.2: Test Access with cURL**
```powershell
# Test API health endpoint
Write-Host "`nTesting API health..." -ForegroundColor Cyan
curl "http://$INGRESS_ADDRESS/ghanshyam/api"

# Test Frontend
Write-Host "`nTesting Frontend..." -ForegroundColor Cyan
$response = Invoke-WebRequest -Uri "http://$INGRESS_ADDRESS/ghanshyam" -UseBasicParsing
Write-Host "Frontend Status: $($response.StatusCode)" -ForegroundColor Green

# Test Admin
Write-Host "`nTesting Admin Dashboard..." -ForegroundColor Cyan
$response = Invoke-WebRequest -Uri "http://$INGRESS_ADDRESS/ghanshyam-admin" -UseBasicParsing
Write-Host "Admin Status: $($response.StatusCode)" -ForegroundColor Green
```

**Expected Output:**
```
Testing API health...
{"status":"ok","message":"Backend is running","database":"connected"}

Testing Frontend...
Frontend Status: 200

Testing Admin Dashboard...
Admin Status: 200
```
<img width="1782" height="509" alt="image" src="https://github.com/user-attachments/assets/7839986c-56a6-4bf5-90f3-6d1c89886dfb" />
<img width="1919" height="944" alt="image" src="https://github.com/user-attachments/assets/66b9e07f-89b2-4ef8-8e12-f25c3e97e540" />


**8.1.3: Open in Browser**
```powershell
# Open in default browser
Start-Process "http://$INGRESS_ADDRESS"
Start-Process "http://$INGRESS_ADDRESS/admin"
```

**Note about Domain Names:**
- The Ingress is configured for `shopnow.<YOUR-USERNAME>.com`
- This requires DNS configuration (Route 53 or your DNS provider)
- **For testing, use the LoadBalancer URL directly** (bypasses DNS)

**8.1.4: Optional - Configure DNS (Production)**

If you want to use custom domain:

```powershell
# Get LoadBalancer address
$LB_ADDRESS = kubectl get ingress shopnow-ingress -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

Write-Host "`nAdd this DNS record in Route 53:" -ForegroundColor Cyan
Write-Host "  Type: CNAME" -ForegroundColor Yellow
Write-Host "  Name: shopnow.john-doe.com" -ForegroundColor Yellow
Write-Host "  Value: $LB_ADDRESS" -ForegroundColor Yellow
Write-Host "  TTL: 300" -ForegroundColor Yellow
```

After DNS propagates (5-10 minutes), access via:
- `http://shopnow.john-doe.com`
- `http://shopnow.john-doe.com/admin`
- `http://shopnow.john-doe.com/api/health`

---

#### Method 2: Using Port Forwarding (Local Testing)

**Best for:** Testing individual services, debugging, local development

**8.2.1: Port Forward Frontend**
```powershell
Write-Host "Port-forwarding Frontend to localhost:3000" -ForegroundColor Yellow
Write-Host "Press Ctrl+C to stop" -ForegroundColor Cyan

kubectl port-forward -n shopnow-demo svc/frontend 3000:80

# Access: http://localhost:3000
```

**Open new PowerShell windows for each service:**

**8.2.2: Port Forward Admin**
```powershell
Write-Host "Port-forwarding Admin to localhost:3001" -ForegroundColor Yellow
kubectl port-forward -n shopnow-demo svc/admin 3001:80

# Access: http://localhost:3001
```

**8.2.3: Port Forward Backend**
```powershell
Write-Host "Port-forwarding Backend to localhost:5000" -ForegroundColor Yellow
kubectl port-forward -n shopnow-demo svc/backend 5000:5000

# Access: http://localhost:5000/api/health
```

**8.2.4: Port Forward MongoDB (for debugging)**
```powershell
Write-Host "Port-forwarding MongoDB to localhost:27017" -ForegroundColor Yellow
kubectl port-forward -n shopnow-demo svc/mongo 27017:27017

# Connect with MongoDB Compass or CLI:
# mongodb://localhost:27017
```

**Background Port Forwarding (PowerShell Jobs):**
```powershell
# Start all port-forwards in background
Start-Job -ScriptBlock { kubectl port-forward -n shopnow-demo svc/frontend 3000:80 }
Start-Job -ScriptBlock { kubectl port-forward -n shopnow-demo svc/admin 3001:80 }
Start-Job -ScriptBlock { kubectl port-forward -n shopnow-demo svc/backend 5000:5000 }

Write-Host "`nPort forwards started in background" -ForegroundColor Green
Write-Host "Access at:" -ForegroundColor Cyan
Write-Host "  Frontend: http://localhost:3000" -ForegroundColor Yellow
Write-Host "  Admin:    http://localhost:3001" -ForegroundColor Yellow
Write-Host "  Backend:  http://localhost:5000/api/health" -ForegroundColor Yellow

# List background jobs
Get-Job

# Stop all jobs when done
# Stop-Job -Name Job*
# Remove-Job -Name Job*
```

---

#### Method 3: Using LoadBalancer Service (Alternative)

**For testing without Ingress:**

**8.3.1: Change Service Type to LoadBalancer**
```powershell
# Patch frontend service
kubectl patch svc frontend -n shopnow-demo -p '{"spec":{"type":"LoadBalancer"}}'

Write-Host "Waiting for External IP (this takes 2-3 minutes)..." -ForegroundColor Cyan

# Wait for EXTERNAL-IP
do {
    $externalIP = kubectl get svc frontend -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
    Start-Sleep -Seconds 5
    Write-Host "." -NoNewline
} while (-not $externalIP)

Write-Host "`n
Frontend External URL: http://$externalIP" -ForegroundColor Green
```

**8.3.2: Test LoadBalancer Service**
```powershell
$externalIP = kubectl get svc frontend -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Test access
curl "http://$externalIP"

# Open in browser
Start-Process "http://$externalIP"
```

**8.3.3: Revert to ClusterIP (when done testing)**
```powershell
# Change back to ClusterIP
kubectl patch svc frontend -n shopnow-demo -p '{"spec":{"type":"ClusterIP"}}'

Write-Host "Service reverted to ClusterIP" -ForegroundColor Green
```

---

#### Method 4: Using kubectl proxy (Advanced)

```powershell
# Start kubectl proxy
Start-Job -ScriptBlock { kubectl proxy }

Write-Host "Proxy started on http://localhost:8001" -ForegroundColor Green

# Access services via proxy
Write-Host "`nAccess via:" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:8001/api/v1/namespaces/shopnow-demo/services/frontend:80/proxy/"
Write-Host "Backend:  http://localhost:8001/api/v1/namespaces/shopnow-demo/services/backend:5000/proxy/api/health"
```

<img width="1880" height="128" alt="image" src="https://github.com/user-attachments/assets/28dd6a75-44b9-4cff-9cb2-bb204da260e7" />
<img width="1914" height="961" alt="image" src="https://github.com/user-attachments/assets/c561a990-293c-4ffa-89a8-4cc6488762dc" />
<img width="1909" height="405" alt="image" src="https://github.com/user-attachments/assets/710d3f29-222f-4c29-a232-4c3517cc23ef" />

---

#### 8.5: Quick Access Summary

```powershell
Write-Host "`n=== APPLICATION ACCESS METHODS ===" -ForegroundColor Green

# Get LoadBalancer URL
$LB_URL = kubectl get ingress shopnow-ingress -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

Write-Host "`n✅ PRODUCTION ACCESS (via Ingress):" -ForegroundColor Cyan
Write-Host "   Frontend: http://$LB_URL"
Write-Host "   Admin:    http://$LB_URL/admin"
Write-Host "   API:      http://$LB_URL/api/health"

Write-Host "`n✅ LOCAL ACCESS (port-forward in separate terminals):" -ForegroundColor Cyan
Write-Host "   kubectl port-forward -n shopnow-demo svc/frontend 3000:80"
Write-Host "   kubectl port-forward -n shopnow-demo svc/admin 3001:80"
Write-Host "   kubectl port-forward -n shopnow-demo svc/backend 5000:5000"
Write-Host "   Then access: http://localhost:3000, http://localhost:3001, http://localhost:5000"

Write-Host "`n✅ RECOMMENDED: Use LoadBalancer URL for testing" -ForegroundColor Green
```

### Step 9: Test the Application

**Purpose**: Validate that all components are working correctly and communicating properly.

#### 9.1: Test Backend API Health

```powershell
Write-Host "=== Testing Backend API ===" -ForegroundColor Cyan

# Get LoadBalancer URL
$LB_URL = kubectl get ingress shopnow-ingress -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Test health endpoint
Write-Host "`nTesting /api/health endpoint..." -ForegroundColor Yellow
$response = Invoke-RestMethod -Uri "http://$LB_URL/api/health" -Method Get

if ($response.status -eq "ok") {
    Write-Host "✅ Backend API is healthy" -ForegroundColor Green
    Write-Host "   Status: $($response.status)"
    Write-Host "   Database: $($response.database)"
} else {
    Write-Host "❌ Backend API health check failed" -ForegroundColor Red
}
```

**Expected Output:**
```
=== Testing Backend API ===

Testing /api/health endpoint...
✅ Backend API is healthy
   Status: ok
   Database: connected
```

**Alternative Using cURL:**
```bash
# Test health endpoint
curl http://$LB_URL/api/health

# Expected: {"status":"ok","database":"connected"}
```

#### 9.2: Test Frontend Accessibility

```powershell
Write-Host "`n=== Testing Frontend ===" -ForegroundColor Cyan

# Test frontend loads
try {
    $response = Invoke-WebRequest -Uri "http://$LB_URL" -UseBasicParsing
    
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Frontend is accessible" -ForegroundColor Green
        Write-Host "   Status Code: $($response.StatusCode)"
        Write-Host "   Content Length: $($response.Content.Length) bytes"
        
        # Check if HTML contains expected content
        if ($response.Content -match "shopnow|ShopNow") {
            Write-Host "   ✅ Page contains expected content" -ForegroundColor Green
        }
    }
} catch {
    Write-Host "❌ Frontend test failed: $($_.Exception.Message)" -ForegroundColor Red
}
```

**Expected Output:**
```
=== Testing Frontend ===
✅ Frontend is accessible
   Status Code: 200
   Content Length: 1523 bytes
   ✅ Page contains expected content
```

#### 9.3: Test Admin Dashboard

```powershell
Write-Host "`n=== Testing Admin Dashboard ===" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri "http://$LB_URL/admin" -UseBasicParsing
    
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Admin dashboard is accessible" -ForegroundColor Green
        Write-Host "   Status Code: $($response.StatusCode)"
    }
} catch {
    Write-Host "❌ Admin test failed: $($_.Exception.Message)" -ForegroundColor Red
}
```

#### 9.4: Test Service-to-Service Communication

**Test Frontend → Backend Connection:**
```powershell
Write-Host "`n=== Testing Service Communication ===" -ForegroundColor Cyan

# Test if frontend can reach backend
Write-Host "Testing Frontend → Backend connection..." -ForegroundColor Yellow

$frontendPod = kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=frontend -o jsonpath='{.items[0].metadata.name}'

kubectl exec -n shopnow-demo $frontendPod -- wget -q -O- http://backend:5000/api/health

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Frontend can communicate with Backend" -ForegroundColor Green
} else {
    Write-Host "❌ Frontend cannot reach Backend" -ForegroundColor Red
}
```

**Expected Output:**
```
Testing Frontend → Backend connection...
{"status":"ok","database":"connected"}
✅ Frontend can communicate with Backend
```

**Test Backend → MongoDB Connection:**
```powershell
Write-Host "`nTesting Backend → MongoDB connection..." -ForegroundColor Yellow

$backendPod = kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=backend -o jsonpath='{.items[0].metadata.name}'

# Check backend logs for MongoDB connection
$logs = kubectl logs -n shopnow-demo $backendPod --tail=50

if ($logs -match "Connected to MongoDB|MongoDB connected|Database connection established") {
    Write-Host "✅ Backend connected to MongoDB" -ForegroundColor Green
} else {
    Write-Host "⚠️  MongoDB connection status unclear" -ForegroundColor Yellow
    Write-Host "   Check logs: kubectl logs -n shopnow-demo $backendPod"
}
```

#### 9.5: Test MongoDB Data Persistence

```powershell
Write-Host "`n=== Testing MongoDB Persistence ===" -ForegroundColor Cyan

# Connect to MongoDB and check databases
$mongoPod = "mongo-0"

Write-Host "Listing MongoDB databases..." -ForegroundColor Yellow
kubectl exec -n shopnow-demo $mongoPod -- mongosh --quiet --eval "db.adminCommand('listDatabases')"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ MongoDB is operational" -ForegroundColor Green
} else {
    Write-Host "❌ MongoDB connection failed" -ForegroundColor Red
}
```

**Expected Output:**
```
=== Testing MongoDB Persistence ===
Listing MongoDB databases...
{
  databases: [
    { name: 'admin', sizeOnDisk: 40960, empty: false },
    { name: 'config', sizeOnDisk: 12288, empty: false },
    { name: 'local', sizeOnDisk: 73728, empty: false },
    { name: 'shopnow', sizeOnDisk: 8192, empty: false }
  ],
  totalSize: 135168,
  ok: 1
}
✅ MongoDB is operational
```
<img width="1918" height="709" alt="image" src="https://github.com/user-attachments/assets/4abbdca3-3ef9-4f74-927d-6f539b2f0bf2" />

#### 9.6: Test Ingress Routing

```powershell
Write-Host "`n=== Testing Ingress Routing ===" -ForegroundColor Cyan

$testResults = @()

# Test root path → Frontend
Write-Host "Testing / → Frontend..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$LB_URL/ghanshyam" -UseBasicParsing -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        $testResults += "✅ / → Frontend (200 OK)"
    }
} catch {
    $testResults += "❌ / → Frontend FAILED"
}

# Test /admin path → Admin
Write-Host "Testing /admin → Admin..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$LB_URL/ghanshyam-admin" -UseBasicParsing -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        $testResults += "✅ /admin → Admin (200 OK)"
    }
} catch {
    $testResults += "❌ /admin → Admin FAILED"
}

# Test /api path → Backend
Write-Host "Testing /api → Backend..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://$LB_URL/ghanshyam/api" -TimeoutSec 10
    if ($response.status -eq "ok") {
        $testResults += "✅ /api → Backend (200 OK)"
    }
} catch {
    $testResults += "❌ /api → Backend FAILED"
}

# Display results
Write-Host "`n=== Ingress Routing Results ===" -ForegroundColor Green
$testResults | ForEach-Object { Write-Host "   $_" }
```

**Expected Output:**
```
=== Testing Ingress Routing ===
Testing / → Frontend...
Testing /admin → Admin...
Testing /api → Backend...

=== Ingress Routing Results ===
   ✅ / → Frontend (200 OK)
   ✅ /admin → Admin (200 OK)
   ✅ /api → Backend (200 OK)
```

#### 9.7: Load Test (Optional)

**Simple load test to trigger HPA:**

```powershell
Write-Host "`n=== Load Testing (HPA Trigger) ===" -ForegroundColor Cyan
Write-Host "Sending 100 requests to trigger autoscaling..." -ForegroundColor Yellow

1..100 | ForEach-Object {
    Start-Job -ScriptBlock {
        param($url)
        Invoke-WebRequest -Uri $url -UseBasicParsing | Out-Null
    } -ArgumentList "http://$LB_URL/api/health"
    
    if ($_ % 10 -eq 0) {
        Write-Host "Sent $_ requests..." -NoNewline -ForegroundColor Cyan
    }
}

Write-Host "`n
Waiting for jobs to complete..."
Get-Job | Wait-Job | Remove-Job

Write-Host "✅ Load test complete" -ForegroundColor Green
Write-Host "`nCheck HPA status:"
kubectl get hpa -n shopnow-demo

Write-Host "`nWait 1-2 minutes, then check if pods scaled:"
Write-Host "kubectl get pods -n shopnow-demo"
```

#### 9.8: Comprehensive Test Summary

```powershell
Write-Host "`n=== COMPREHENSIVE TEST SUMMARY ===" -ForegroundColor Green

$tests = @{
    "Backend Health"         = $true   # Update based on actual results
    "Frontend Accessible"    = $true
    "Admin Accessible"       = $true
    "Frontend-Backend Comm" = $true
    "Backend-MongoDB Conn"  = $true
    "MongoDB Operational"    = $true
    "Ingress Routing"        = $true
}

$passed = ($tests.Values | Where-Object { $_ -eq $true }).Count
$total = $tests.Count

Write-Host "`nTest Results: $passed / $total passed" -ForegroundColor Cyan

foreach ($test in $tests.GetEnumerator()) {
    if ($test.Value) {
        Write-Host "   ✅ $($test.Key)" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $($test.Key)" -ForegroundColor Red
    }
}

if ($passed -eq $total) {
    Write-Host "`n✅ ALL TESTS PASSED!" -ForegroundColor Green
    Write-Host "Your application is fully operational." -ForegroundColor Green
} else {
    Write-Host "`n⚠️  SOME TESTS FAILED" -ForegroundColor Yellow
    Write-Host "Review logs and troubleshoot failed components." -ForegroundColor Yellow
}
```

**Expected Output:**
```
=== COMPREHENSIVE TEST SUMMARY ===

Test Results: 7 / 7 passed
   ✅ Backend Health
   ✅ Frontend Accessible
   ✅ Admin Accessible
   ✅ Frontend-Backend Comm
   ✅ Backend-MongoDB Conn
   ✅ MongoDB Operational
   ✅ Ingress Routing

✅ ALL TESTS PASSED!
Your application is fully operational.
```
<img width="1879" height="633" alt="image" src="https://github.com/user-attachments/assets/9f90dd5e-ef0b-4de5-b75d-5e7792a22a6b" />

### Step 10: Monitor Application

**Purpose**: Set up monitoring and observability to track application health and performance.

#### 10.1: Real-time Pod Monitoring

**Watch Pods in Real-time:**
```powershell
Write-Host "=== Real-time Pod Monitoring ===" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
Write-Host ""

kubectl get pods -n shopnow-demo -w
```

**Expected Output (updates continuously):**
```
NAME                       READY   STATUS    RESTARTS   AGE
admin-xxx                  1/1     Running   0          10m
backend-xxx                1/1     Running   0          15m
frontend-xxx               1/1     Running   0          10m
mongo-0                    1/1     Running   0          20m

# Updates appear as changes occur:
backend-xxx                1/1     Running   0          15m
backend-yyy                0/1     Pending   0          0s
backend-yyy                0/1     ContainerCreating   0          1s
backend-yyy                1/1     Running             0          5s
```

**Watch with Auto-refresh Dashboard:**
```powershell
# PowerShell script for continuous monitoring
while ($true) {
    Clear-Host
    Write-Host "=== ShopNow Monitoring Dashboard ===" -ForegroundColor Green
    Write-Host "Updated: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "PODS:" -ForegroundColor Yellow
    kubectl get pods -n shopnow-demo
    
    Write-Host "`nRESOURCE USAGE:" -ForegroundColor Yellow
    kubectl top pods -n shopnow-demo 2>$null
    
    Write-Host "`nHPA STATUS:" -ForegroundColor Yellow
    kubectl get hpa -n shopnow-demo
    
    Write-Host "`nPress Ctrl+C to exit" -ForegroundColor Gray
    Start-Sleep -Seconds 5
}
```

#### 10.2: Resource Usage Monitoring

**Check Node Resources:**
```powershell
Write-Host "`n=== Node Resource Usage ===" -ForegroundColor Cyan
kubectl top nodes
```

**Expected Output:**
```
NAME                              CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
ip-192-168-10-20.ec2.internal     450m         22%    2500Mi          62%
ip-192-168-20-30.ec2.internal     380m         19%    2100Mi          52%
```

**Check Pod Resources:**
```powershell
Write-Host "`n=== Pod Resource Usage ===" -ForegroundColor Cyan
kubectl top pods -n shopnow-demo
```

**Expected Output:**
```
NAME                       CPU(cores)   MEMORY(bytes)
admin-xxx                  5m           45Mi
backend-xxx                25m          120Mi
frontend-xxx               3m           40Mi
mongo-0                    15m          250Mi
```

**What These Numbers Mean:**
- **CPU**: Millicores (1000m = 1 core)
- **Memory**: Mebibytes (MiB)
- **Healthy ranges**:
  - nginx (frontend/admin): 2-10m CPU, 30-60Mi RAM
  - Node.js (backend): 10-50m CPU, 100-200Mi RAM
  - MongoDB: 10-30m CPU, 200-400Mi RAM (idle)

#### 10.3: HPA (Auto-scaling) Monitoring

**Watch HPA Status:**
```powershell
Write-Host "`n=== Horizontal Pod Autoscaler Monitoring ===" -ForegroundColor Cyan
kubectl get hpa -n shopnow-demo -w
```

**Expected Output:**
```
NAME       REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
admin      Deployment/admin      15%/80%   1         3         1          15m
backend    Deployment/backend    25%/80%   1         3         1          20m
frontend   Deployment/frontend   8%/80%    1         3         1          15m

# When load increases:
backend    Deployment/backend    85%/80%   1         3         1          20m
backend    Deployment/backend    85%/80%   1         3         2          20m
backend    Deployment/backend    45%/80%   1         3         2          21m
```

**Detailed HPA Info:**
```powershell
Write-Host "Detailed HPA information:" -ForegroundColor Yellow

@("admin", "backend", "frontend") | ForEach-Object {
    Write-Host "`n--- $_ HPA ---" -ForegroundColor Cyan
    kubectl describe hpa "$_-hpa" -n shopnow-demo 2>$null
}
```

**Expected Output:**
```
Name:                        backend-hpa
Namespace:                   shopnow-demo
Reference:                   Deployment/backend
Metrics:                     ( current / target )
  resource cpu on pods:      25% (25m) / 80%
Min replicas:                1
Max replicas:                3
Deployment pods:             1 current / 1 desired
Conditions:
  Type            Status  Reason              Message
  ----            ------  ------              -------
  AbleToScale     True    ReadyForNewScale    recent recommendations were higher than current
  ScalingActive   True    ValidMetricFound    HPA was able to successfully calculate a replica count
Events:
  Type    Reason             Message
  ----    ------             -------
  Normal  SuccessfulRescale  New size: 2; reason: cpu resource utilization above target
```

#### 10.4: Application Logs Monitoring

**View Recent Events:**
```powershell
Write-Host "`n=== Recent Cluster Events ===" -ForegroundColor Cyan
kubectl get events -n shopnow-demo --sort-by='.lastTimestamp' | Select-Object -Last 20
```

**Stream Backend Logs:**
```powershell
Write-Host "`n=== Streaming Backend Logs ===" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow

kubectl logs -n shopnow-demo -l app.kubernetes.io/name=backend -f --tail=50
```

**Stream All Application Logs:**
```powershell
Write-Host "Streaming logs from all application pods..." -ForegroundColor Yellow

# Stream logs from all pods (requires stern or kubetail)
# Using kubectl (shows one pod at a time)
kubectl logs -n shopnow-demo --selector='app.kubernetes.io/name in (backend,frontend,admin)' --all-containers=true -f
```

**Check Logs for Errors:**
```powershell
Write-Host "`n=== Checking for Errors in Logs ===" -ForegroundColor Cyan

$pods = kubectl get pods -n shopnow-demo -o name

foreach ($pod in $pods) {
    Write-Host "`nChecking $pod for errors..." -ForegroundColor Yellow
    
    $errors = kubectl logs -n shopnow-demo $pod --tail=100 | Select-String -Pattern "error|exception|failed|fatal" -CaseSensitive:$false
    
    if ($errors) {
        Write-Host "⚠️  Found errors in $pod:" -ForegroundColor Red
        $errors | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
    } else {
        Write-Host "✅ No errors found in $pod" -ForegroundColor Green
    }
}
```

#### 10.5: Network Traffic Monitoring

**Monitor Service Endpoints:**
```powershell
Write-Host "`n=== Service Endpoints ===" -ForegroundColor Cyan
kubectl get endpoints -n shopnow-demo
```

**Expected Output:**
```
NAME       ENDPOINTS                                   AGE
admin      10.0.2.10:80                                15m
backend    10.0.1.15:5000                              20m
frontend   10.0.2.20:80                                15m
mongo      10.0.1.5:27017                              25m
```

**Test Service DNS Resolution:**
```powershell
Write-Host "`n=== Testing Service DNS ===" -ForegroundColor Cyan

$backendPod = kubectl get pods -n shopnow-demo -l app.kubernetes.io/name=backend -o jsonpath='{.items[0].metadata.name}'

Write-Host "Testing DNS resolution from backend pod..." -ForegroundColor Yellow
kubectl exec -n shopnow-demo $backendPod -- nslookup mongo
kubectl exec -n shopnow-demo $backendPod -- nslookup frontend
```

#### 10.6: Persistent Storage Monitoring

**Check PVC Status:**
```powershell
Write-Host "`n=== Persistent Volume Claims ===" -ForegroundColor Cyan
kubectl get pvc -n shopnow-demo
```

**Check PV Usage:**
```powershell
Write-Host "`n=== MongoDB Storage Usage ===" -ForegroundColor Cyan

# Check MongoDB data directory size
kubectl exec -n shopnow-demo mongo-0 -- du -sh /data/db

# Check available space
kubectl exec -n shopnow-demo mongo-0 -- df -h /data/db
```

**Expected Output:**
```
450M    /data/db

Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme1n1    4.9G  450M  4.5G  10% /data/db
```

#### 10.7: Health Check Dashboard

**Create Comprehensive Monitoring Script:**

```powershell
# Save as: monitor-shopnow.ps1

function Get-ShopNowStatus {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "   ShopNow Monitoring Dashboard" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
    Write-Host ""
    
    # Pod Status
    Write-Host "[PODS]" -ForegroundColor Yellow
    $pods = kubectl get pods -n shopnow-demo --no-headers
    $runningCount = ($pods | Select-String "Running").Count
    $totalCount = ($pods | Measure-Object).Count
    Write-Host "  Running: $runningCount / $totalCount"
    kubectl get pods -n shopnow-demo | ForEach-Object { Write-Host "  $_" }
    
    # Resource Usage
    Write-Host "`n[RESOURCE USAGE]" -ForegroundColor Yellow
    kubectl top pods -n shopnow-demo 2>$null | ForEach-Object { Write-Host "  $_" }
    
    # HPA Status
    Write-Host "`n[AUTO-SCALING]" -ForegroundColor Yellow
    kubectl get hpa -n shopnow-demo --no-headers | ForEach-Object { Write-Host "  $_" }
    
    # Service Status
    Write-Host "`n[SERVICES]" -ForegroundColor Yellow
    kubectl get svc -n shopnow-demo --no-headers | ForEach-Object { Write-Host "  $_" }
    
    # Ingress
    Write-Host "`n[INGRESS]" -ForegroundColor Yellow
    $ingressUrl = kubectl get ingress shopnow-ingress -n shopnow-demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' 2>$null
    Write-Host "  URL: http://$ingressUrl"
    
    # Recent Events (last 5)
    Write-Host "`n[RECENT EVENTS]" -ForegroundColor Yellow
    kubectl get events -n shopnow-demo --sort-by='.lastTimestamp' | Select-Object -Last 5 | ForEach-Object { Write-Host "  $_" }
    
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "Press Ctrl+C to exit | Auto-refresh: 10s" -ForegroundColor Gray
}

# Run monitoring loop
while ($true) {
    Get-ShopNowStatus
    Start-Sleep -Seconds 10
}
```

**Run the Monitoring Dashboard:**
```powershell
# Run the monitoring script
.\monitor-shopnow.ps1
```

#### 10.8: Set Up Alerts (Optional)

**Monitor for Pod Failures:**
```powershell
# Simple alert script
function Check-PodHealth {
    $failedPods = kubectl get pods -n shopnow-demo --field-selector=status.phase!=Running --no-headers
    
    if ($failedPods) {
        Write-Host "⚠️  ALERT: Pods not running!" -ForegroundColor Red
        $failedPods | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        
        # Send notification (customize this)
        # Send-MailMessage or Invoke-WebRequest to webhook
    } else {
        Write-Host "✅ All pods healthy" -ForegroundColor Green
    }
}

# Run health check every 30 seconds
while ($true) {
    Check-PodHealth
    Start-Sleep -Seconds 30
}
```

#### 10.9: Monitoring Best Practices

```powershell
Write-Host "`n=== Monitoring Best Practices ===" -ForegroundColor Green

Write-Host "`n✅ Regular Checks:" -ForegroundColor Cyan
Write-Host "   1. Monitor pod status every 5-10 minutes"
Write-Host "   2. Check resource usage hourly"
Write-Host "   3. Review logs daily for errors"
Write-Host "   4. Verify HPA is working during load"

Write-Host "`n✅ Key Metrics to Track:" -ForegroundColor Cyan
Write-Host "   - Pod restarts (should be 0 or very low)"
Write-Host "   - CPU usage (should be < 80% consistently)"
Write-Host "   - Memory usage (should not be near limits)"
Write-Host "   - Response times (< 200ms for API)"
Write-Host "   - Error rates in logs"

Write-Host "`n✅ Commands for Quick Checks:" -ForegroundColor Cyan
Write-Host "   kubectl get pods -n shopnow-demo"
Write-Host "   kubectl top pods -n shopnow-demo"
Write-Host "   kubectl get hpa -n shopnow-demo"
Write-Host "   kubectl logs -n shopnow-demo <pod-name> --tail=50"
Write-Host "   kubectl describe pod -n shopnow-demo <pod-name>"

Write-Host "`n✅ Recommended Tools:" -ForegroundColor Cyan
Write-Host "   - Kubernetes Dashboard (web UI)"
Write-Host "   - Prometheus + Grafana (metrics)"
Write-Host "   - ELK Stack (log aggregation)"
Write-Host "   - AWS CloudWatch (AWS integration)"
Write-Host "   - kubectl-top plugin (enhanced metrics)"
```

---

## 🔄 Quick Commands Summary

```bash
# Start everything
kubectl apply -f kubernetes/k8s-manifests/namespace/
kubectl apply -f kubernetes/pre-req/
helm install mongo kubernetes/helm/charts/mongo -n shopnow-demo
helm install backend kubernetes/helm/charts/backend -n shopnow-demo
helm install frontend kubernetes/helm/charts/frontend -n shopnow-demo
helm install admin kubernetes/helm/charts/admin -n shopnow-demo
kubectl apply -f kubernetes/k8s-manifests/ingress/

# Stop everything
helm uninstall admin -n shopnow-demo
helm uninstall frontend -n shopnow-demo
helm uninstall backend -n shopnow-demo
helm uninstall mongo -n shopnow-demo
kubectl delete namespace shopnow-demo

# Update/Upgrade
helm upgrade backend kubernetes/helm/charts/backend -n shopnow-demo
helm upgrade frontend kubernetes/helm/charts/frontend -n shopnow-demo

# Restart pods
kubectl rollout restart deployment/backend -n shopnow-demo
kubectl rollout restart deployment/frontend -n shopnow-demo
kubectl rollout restart deployment/admin -n shopnow-demo
```

---

## 🚨 Common Issues & Solutions

**Issue: Pods stuck in `ImagePullBackOff`**
```bash
# Check if image exists in ECR
aws ecr describe-images --repository-name shopnow/backend --region $AWS_REGION

# Verify image name in deployment
kubectl get deployment backend -n shopnow-demo -o yaml | grep image:

# Check ECR permissions
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
```

**Issue: MongoDB pod in `CrashLoopBackOff`**
```bash
# Check logs
kubectl logs -f statefulset/mongo -n shopnow-demo

# Check PVC
kubectl get pvc -n shopnow-demo

# Verify StorageClass
kubectl get storageclass
```

**Issue: Backend can't connect to MongoDB**
```bash
# Verify MongoDB service
kubectl get svc mongo -n shopnow-demo

# Check backend environment variables
kubectl describe deployment backend -n shopnow-demo | grep -A 10 Environment

# Test connection from backend pod
kubectl exec -it deployment/backend -n shopnow-demo -- curl mongodb://mongo:27017
```


## 🔄 CI/CD Pipelines (Core Requirement)

**Assignment Requirement**: Automate build and deployment using Jenkins Groovy pipelines.

### Jenkins Setup

1. **Create Jenkins Jobs**:
   - 3 CI jobs (backend, frontend, admin)
   - 3 CD jobs (backend, frontend, admin)

2. **Configure Pipelines**:
   - Use Jenkinsfile from `jenkins/` directory
   - Set up SCM polling or webhooks
   - Configure AWS credentials in Jenkins

3. **Run Pipelines**:
   - CI: Builds Docker image and pushes to ECR
   - CD: Deploys to Kubernetes using HELM

### jenkins credential update ###
<img width="1912" height="949" alt="image" src="https://github.com/user-attachments/assets/7d10e2e7-049c-45ab-a541-402537fda8ff" />
### jenkins environment update ###
<img width="1888" height="960" alt="image" src="https://github.com/user-attachments/assets/f7605096-c4c3-4ef7-99d6-196e47222a51" />

### Create Backend CI Pipeline ###

<img width="1920" height="3700" alt="image" src="https://github.com/user-attachments/assets/2e3842b8-c771-4328-9abb-f67d349b5c5c" />

## set Github Webhooks ##
<img width="1920" height="1400" alt="image" src="https://github.com/user-attachments/assets/437a995f-6b40-49a5-be29-5a1399f72f34" />

### Create Frontend CI Pipeline ###
<img width="1920" height="3680" alt="image" src="https://github.com/user-attachments/assets/2dadb478-7cd7-4c4e-8850-6ee9e8db79cb" />

### Create Admin CI Pipeline ###
<img width="1920" height="3506" alt="image" src="https://github.com/user-attachments/assets/a28bd7b8-0219-43ec-91b1-52643f38113f" />

### Create Backend CD Pipeline ###
<img width="1920" height="4292" alt="image" src="https://github.com/user-attachments/assets/837ede4f-ab9f-42f2-9221-6adc59cebc14" />

### Create Frontend CD Pipeline ###
<img width="1920" height="4292" alt="image" src="https://github.com/user-attachments/assets/f4c30a6d-2d74-4e06-b650-bae1f7172cf6" />

### Create Admin CD Pipeline ###
<img width="1920" height="4292" alt="image" src="https://github.com/user-attachments/assets/994acba6-d45e-433a-b151-304eda0f0eae" />

### List of CI/CD Pipeline ###
<img width="1919" height="845" alt="image" src="https://github.com/user-attachments/assets/9a9d2f8d-6dd4-427d-9f7c-8b23ca0dfc97" />

### Backend CI Pipeline Output ###
<img width="1920" height="7716" alt="image" src="https://github.com/user-attachments/assets/c45e42ac-c914-4af3-9b7a-363f7c57d839" />
<img width="1919" height="957" alt="image" src="https://github.com/user-attachments/assets/269ea0b2-900d-41d7-89d8-e36b587473ae" />
<img width="1919" height="972" alt="image" src="https://github.com/user-attachments/assets/700672e8-2b52-464c-a8df-946a8f782d51" />

### Backend CD Pipeline Output ###
<img width="1920" height="9112" alt="image" src="https://github.com/user-attachments/assets/c8b06ad3-213a-4b1f-8695-4debbe8b3c7d" />
<img width="1919" height="958" alt="image" src="https://github.com/user-attachments/assets/88f67db9-84d4-4ba4-8ecd-a482997cd417" />
<img width="1914" height="957" alt="image" src="https://github.com/user-attachments/assets/c0e06fa8-5241-444b-b1ff-d346169a0d60" />

### Admin CI Pipeline Output ###
<img width="1920" height="8589" alt="image" src="https://github.com/user-attachments/assets/cdba8419-0b12-4a72-a1f3-6678812dae69" />
<img width="1910" height="962" alt="image" src="https://github.com/user-attachments/assets/e063dd53-5d4d-4870-b7f0-41277e574068" />
<img width="1894" height="854" alt="image" src="https://github.com/user-attachments/assets/4bf77b81-8bd3-4130-a266-eac70c75fde3" />

### Admin CD Pipeline Output ###
<img width="1920" height="8677" alt="image" src="https://github.com/user-attachments/assets/7093557d-db2b-44dd-99e5-d31a36df5337" />
<img width="1897" height="864" alt="image" src="https://github.com/user-attachments/assets/b122cddf-2fe5-4474-a929-70c6fa42204f" />
<img width="1919" height="957" alt="image" src="https://github.com/user-attachments/assets/993d3c70-26cb-4763-b31c-44a76f870619" />

### Frontend CI Pipeline Output ###
<img width="1920" height="9316" alt="image" src="https://github.com/user-attachments/assets/f0a0f2e6-8267-41ce-9610-98c03a19356b" />
<img width="1910" height="966" alt="image" src="https://github.com/user-attachments/assets/5575b3d9-67e5-49ae-8514-b44a018753ae" />
<img width="1915" height="962" alt="image" src="https://github.com/user-attachments/assets/649c97eb-6302-460b-83a1-76667fba904f" />

### Frontend CD Pipeline Output ###
<img width="1920" height="8618" alt="image" src="https://github.com/user-attachments/assets/8897eebc-1b86-46cd-824a-19297316407e" />
<img width="1889" height="865" alt="image" src="https://github.com/user-attachments/assets/2b1bbac1-0e56-4fcd-9b41-b8b38cd28c10" />
<img width="1919" height="948" alt="image" src="https://github.com/user-attachments/assets/9d360869-afe1-4e18-956d-405dbe5482a4" />

### GIT Commit ###
<img width="1794" height="1002" alt="image" src="https://github.com/user-attachments/assets/bc6308d5-7c6d-4124-a6d6-b3e34fdbd301" />

### Automated Deployment Started ###
<img width="1914" height="963" alt="image" src="https://github.com/user-attachments/assets/46271aac-94d4-44ed-b2d1-e69120e82f30" />
<img width="1917" height="951" alt="image" src="https://github.com/user-attachments/assets/26449c4a-8de5-4d6d-8ac2-92ff43117cbe" />
<img width="1914" height="928" alt="image" src="https://github.com/user-attachments/assets/5c0d7590-28b9-4d42-a8fa-dfc95d8593dd" />
