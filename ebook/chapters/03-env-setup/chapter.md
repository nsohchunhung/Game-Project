# Chapter 3: Environment Setup

*Install and configure all tools needed for production-grade DevOps development*

---

## What You'll Learn
- Complete development environment setup for DevOps workflows
- Tool installation and verification procedures
- System resource requirements and optimization
- Troubleshooting common installation issues

## Time Required: 30 minutes

## Prerequisites: [Chapter 2: Architecture Overview](02-architecture.md)

---

## Why This Matters

Professional DevOps work requires a properly configured toolchain. Installing tools correctly the first time prevents hours of debugging later. Think of this as setting up your workshop before building a house - you need the right tools to build something that actually works.

**Professional Context**: Every DevOps team has a standardized development environment. Learning to set up and maintain developer tooling is a fundamental skill that demonstrates attention to detail and operational thinking.

## Required Tools Overview

The tools you'll install are used daily by professional DevOps engineers:

| Tool | Purpose | Career Relevance |
|------|---------|------------------|
| **Docker** | Container runtime | Essential for modern application deployment |
| **kubectl** | Kubernetes CLI | Required for any Kubernetes operation |
| **k3d** | Local Kubernetes | Industry standard for local development |
| **Helm** | Kubernetes package manager | Used in 80%+ of Kubernetes deployments |
| **Node.js** | JavaScript runtime | Powers the application backend |
| **jq** | JSON processor | Critical for DevOps automation scripts |

## System Requirements

**Minimum Requirements:**
- **RAM**: 4GB available (8GB recommended)
- **Storage**: 10GB free disk space
- **Network**: Stable internet for image downloads
- **OS**: macOS, Linux, or Windows with WSL2

**Resource Planning:**
- Kubernetes cluster: ~2GB RAM
- Application stack: ~1GB RAM  
- Container images: ~3GB storage
- Development tools: ~1GB storage

## Tool Installation

### macOS Installation (Recommended)

The fastest path for macOS users is Homebrew:

# 🍺 macOS Tool Installation
# Install all required DevOps tools using Homebrew package manager

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all required tools
brew install docker docker-compose kubectl k3d helm nodejs jq
```

**Expected Output:**

# 📦 Homebrew Installation Output
# Successful installation confirmation for all DevOps tools

```bash
==> Installing docker
==> Installing docker-compose
==> Installing kubectl
==> Installing k3d
==> Installing helm
==> Installing nodejs
==> Installing jq
🍺  docker, docker-compose, kubectl, k3d, helm, nodejs, jq were successfully installed
```

**⚠️ Important**: You also need Docker Desktop for the container runtime:

# 🐳 Docker Desktop Installation
# Alternative container runtime setup for macOS

```bash
# Download and install Docker Desktop
# Visit: https://www.docker.com/products/docker-desktop
# Or install via Homebrew Cask:
brew install --cask docker
```

**Alternative**: If you prefer Colima over Docker Desktop [[memory: 6996562]]:

# 🚀 Colima Docker Alternative
# Lightweight Docker runtime for macOS without Docker Desktop

```bash
# Install Colima as Docker Desktop alternative
brew install colima

# Start Colima
colima start
```

### Linux Installation (Ubuntu/Debian)

For Linux systems, install each tool separately:

# 🐧 Linux Tool Installation
# Step-by-step installation for Ubuntu/Debian systems

```bash
# Update package index
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker  # Apply group changes immediately
```

**Expected Output:**

# 📋 Linux Installation Output
# Confirmation of successful Docker installation on Linux

```bash
Reading package lists... Done
Building dependency tree... Done
docker.io is already the newest version (20.10.21)
docker-compose is already the newest version (1.25.0)
Adding user to docker group...
```

# ☸️ kubectl Installation
# Install Kubernetes command-line tool for cluster management

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl  # Clean up downloaded file
```

# 🎯 k3d Installation
# Install lightweight Kubernetes distribution for local development

```bash
# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

**💡 Pro Tip**: k3d is a lightweight Kubernetes distribution that runs inside Docker containers. It's perfect for development because it starts quickly, uses minimal resources, and provides a real Kubernetes experience without cluster management overhead.

# ⚓ Helm Installation
# Install Kubernetes package manager for application deployment

```bash
# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

# 📦 Node.js and jq Installation
# Install JavaScript runtime and JSON processor

```bash
# Install Node.js and jq
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs jq
```

### Windows with WSL2

For Windows users, enable WSL2 first, then follow the Linux instructions above.

# 🪟 Windows WSL2 Setup
# Enable Windows Subsystem for Linux for development environment

```powershell
# Enable WSL2 (run in PowerShell as Administrator)
wsl --install

# Restart your computer, then install Ubuntu from Microsoft Store
# Follow Linux installation steps inside Ubuntu terminal
```

## Tool Verification

After installation, verify each tool is working correctly:

# 🔍 Tool Verification Commands
# Verify all installed tools are working correctly

```bash
# Check Docker
docker --version
docker info
```

**Expected Output:**

# ✅ Docker Verification Output
# Confirmation that Docker daemon is running properly

```bash
Docker version 20.10.21, build 20.10.21-0ubuntu1~20.04.2
Client:
 Context:    default
 Debug Mode: false
Server:
 Server Version: 20.10.21
 Storage Driver: overlay2
 Total Memory: 4.096GiB
```

# ☸️ Kubernetes Tools Verification
# Check versions of kubectl, k3d, and Helm

```bash
# Check Kubernetes tools
kubectl version --client
k3d version
helm version
```

**Expected Output:**

# 📊 Kubernetes Tools Version Output
# Confirmation of installed Kubernetes tool versions

```bash
Client Version: version.Info{Major:"1", Minor:"28", GitVersion:"v1.28.0"}
k3d version v5.6.0
version.BuildInfo{Version:"v3.12.3", GitCommit:"3a31588"}
```

# 🛠️ Development Tools Verification
# Check Node.js, npm, and jq versions

```bash
# Check development tools
node --version
npm --version
jq --version
```

**Expected Output:**

# 📈 Development Tools Version Output
# Confirmation of Node.js, npm, and jq installations

```bash
v18.17.1
8.19.4
jq-1.6
```

### Test Docker Functionality

Verify Docker is working with a simple test:

# 🧪 Docker Functionality Test
# Run hello-world container to verify Docker daemon

```bash
# Test Docker daemon
docker run hello-world
```

**Expected Output:**

# 🎉 Docker Hello World Test Output
# Successful Docker daemon verification

```bash
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
```

[[ADD IMAGE: Terminal output showing successful hello-world Docker container]]

## System Resource Check

Verify your system has sufficient resources:

# 💻 System Resource Check
# Verify available memory and disk space

```bash
# Check available memory (macOS)
vm_stat | head -10

# Check available memory (Linux)
free -h

# Check disk space
df -h
```

**Expected Output:**

# 📊 System Resource Status
# Memory and disk space availability confirmation

```bash
              total        used        free      shared  buff/cache   available
Mem:          7.8Gi       2.1Gi       3.2Gi       0.5Gi       2.5Gi       5.1Gi
Swap:         2.0Gi          0B       2.0Gi

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   25G   23G  53% /
```

**⚠️ Resource Requirements**: Ensure you have at least 4GB available memory and 10GB free disk space before proceeding.

## Project Setup

Clone the project repository and verify structure:

# 📁 Project Repository Setup
# Clone and verify the DevOps Home Lab project structure

```bash
# Clone the repository
git clone https://github.com/Osomudeya/DevOps-Home-Lab-2025.git
cd DevOps-Home-Lab-2025

# Verify project structure
ls -la
```

**Expected Output:**

# 📂 Project Structure Verification
# Confirmation of cloned repository contents

```bash
total 24
drwxr-xr-x  12 user  staff   384 Jan 15 10:30 .
drwxr-xr-x   5 user  staff   160 Jan 15 10:30 ..
drwxr-xr-x   8 user  staff   256 Jan 15 10:30 .github
-rw-r--r--   1 user  staff  1234 Jan 15 10:30 README.md
drwxr-xr-x   5 user  staff   160 Jan 15 10:30 backend
drwxr-xr-x   7 user  staff   224 Jan 15 10:30 docs
drwxr-xr-x   4 user  staff   128 Jan 15 10:30 frontend
drwxr-xr-x  12 user  staff   384 Jan 15 10:30 k8s
-rw-r--r--   1 user  staff  2156 Jan 15 10:30 Makefile
drwxr-xr-x   8 user  staff   256 Jan 15 10:30 scripts
```

# 🔧 Project Automation Test
# Verify Makefile commands are available

```bash
# Test project automation
make help
```

**Expected Output:**

# 🎮 Makefile Help Output
# Available automation commands for the project

```bash
🎮 Production Kubernetes Homelab - Quick Commands

🚀 Deployment Commands:
  setup-cluster        Create and configure k3d cluster
  deploy-all           Deploy complete infrastructure
  deploy-app           Deploy the main application

🔍 Testing & Verification:
  verify               Verify all deployments
  test-endpoints       Test application endpoints
```

## Environment Verification

Run the complete verification script:

# ✅ Environment Verification Script
# Comprehensive check of all installed tools and system resources

```bash
# Verify complete environment
./scripts/verify.sh
```

This script checks:
- Tool versions and functionality
- System resource availability  
- Docker daemon status
- Network connectivity
- Project file structure

[[ADD IMAGE: Verification script output showing all green checkmarks]]

## ✅ Checkpoint

Your environment is ready when:
- ✅ All 7 tools show version numbers without errors
- ✅ Docker daemon is running and accessible  
- ✅ At least 4GB RAM and 10GB disk space available
- ✅ Project repository cloned and structure verified
- ✅ `docker run hello-world` completes successfully
- ✅ `make help` displays available commands

## Troubleshooting Common Issues

### Issue: Docker Permission Errors

**Symptom:**
```bash
docker: permission denied while trying to connect to the Docker daemon
```

**Cause**: User not in docker group (Linux) or Docker Desktop not running (macOS)

**Fix for Linux:**

# 🔧 Linux Docker Permission Fix
# Add user to docker group and apply changes

```bash
sudo usermod -aG docker $USER
newgrp docker
# Test: docker run hello-world
```

**Fix for macOS:**

# 🍎 macOS Docker Desktop Fix
# Start Docker Desktop application

```bash
# Ensure Docker Desktop is running
open -a Docker
# Wait for Docker Desktop to start completely
```

### Issue: kubectl Command Not Found

**Symptom:**
```bash
kubectl: command not found
```

**Cause**: kubectl not in PATH or not installed correctly

**Fix:**

# 🔧 kubectl Installation Fix
# Reinstall kubectl if command not found

```bash
# Check if kubectl exists
which kubectl

# If not found, reinstall
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

# Verify installation
kubectl version --client
```

### Issue: Insufficient System Resources

**Symptom:**
- Docker containers fail to start
- System becomes unresponsive
- "No space left on device" errors

**Diagnosis:**

# 🔍 Resource Usage Diagnosis
# Check system memory, disk, and Docker resource consumption

```bash
# Check memory usage
free -h

# Check disk usage
df -h

# Check Docker resource usage
docker system df
```

**Fix:**

# 🧹 System Resource Cleanup
# Clean Docker system and optimize resource usage

```bash
# Clean Docker system
docker system prune -a --volumes

# Close unnecessary applications
# Consider increasing VM memory allocation if using Docker Desktop
```

### Issue: k3d Cluster Creation Fails

**Symptom:**
```bash
ERRO[0000] Failed to create cluster 'dev-cluster'
```

**Cause**: Docker not running or port conflicts

**Fix:**

# 🔧 k3d Cluster Creation Fix
# Resolve Docker and port conflicts for cluster creation

```bash
# Ensure Docker is running
docker info

# Check for port conflicts
lsof -i :8080
lsof -i :8090

# Delete existing cluster if any
k3d cluster delete dev-cluster

# Retry cluster creation
k3d cluster create dev-cluster --port "8080:80@loadbalancer" --port "8090:443@loadbalancer"
```

## Reset Procedures

If you need to start over completely:

# 🗑️ Complete Environment Reset
# Nuclear option to clean all installations and start fresh

```bash
# Remove all Docker containers and images
docker system prune -a --volumes

# Remove k3d clusters
k3d cluster delete --all

# Clean Helm repositories
helm repo list
helm repo remove <repo-name>

# For complete reset on macOS
brew uninstall docker docker-compose kubectl k3d helm nodejs jq
# Reinstall with original commands
```

## Performance Optimization

### macOS Docker Desktop Settings

**Recommended Settings:**
- **Memory**: 4-6GB (depending on system RAM)
- **CPU**: 2-4 cores
- **Disk Image Size**: 32GB+
- **Enable VirtioFS**: For better file sharing performance

### Linux Resource Limits

# ⚙️ Linux Resource Optimization
# Increase system limits for container workloads

```bash
# Increase container limits if needed
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

## Domain Configuration (CRITICAL)

### Step 6: Configure Your Domain

**⚠️ IMPORTANT**: This project uses `gameapp.games` as an example domain. You MUST replace it with your own domain before proceeding.

**Option A: Use Your Own Domain**
```bash
# If you have a domain (e.g., myapp.com), replace all instances:
# gameapp.games → myapp.com
# app.gameapp.games → app.myapp.com
# prometheus.gameapp.games → prometheus.myapp.com
```

**Option B: Get a Free Domain**
```bash
# Free domain options:
# 1. Freenom (.tk, .ml, .ga domains)
# 2. Duck DNS (duckdns.org)
# 3. No-IP (noip.com)
# 4. Use localhost for testing (not recommended for production)
```

**Option C: Use Localhost (Testing Only)**
```bash
# Add to /etc/hosts (macOS/Linux) or C:\Windows\System32\drivers\etc\hosts (Windows)
echo "127.0.0.1 gameapp.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 prometheus.gameapp.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 grafana.gameapp.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 argocd.gameapp.local" | sudo tee -a /etc/hosts
```

### Step 7: Domain Replacement Checklist

**Files that need domain updates:**
```bash
# Core application files
k8s/ingress.yaml                    # Lines 15, 59, 122, 123, 146, 156, 185, 198
k8s/monitoring-ingress.yaml         # Lines 12, 25, 38, 51
k8s/tunnel-ingress.yaml            # Lines 15, 28, 41, 54
k8s/unified-ingress.yaml           # Lines 15, 28, 41, 54, 67, 80, 93, 106

# Configuration files
k8s/configmap.yaml                 # Lines 8, 12, 16, 20
k8s/frontend-config.yaml           # Lines 8, 12, 16, 20

# Scripts
scripts/verify.sh                  # Lines 45, 48, 51, 54
scripts/test-traffic.sh            # Lines 8, 12, 16, 20
scripts/production-metrics-test.sh # Lines 8, 12, 16, 20

# Documentation
docs/07-global.md                  # Multiple references
docs/cloudflare-tunnel-setup-guide.md # Multiple references
```

**Quick domain replacement script:**

# 🔄 Domain Replacement Script
# Automated script to replace example domain with your actual domain

```bash
# Replace domain in all files (replace YOUR_DOMAIN with your actual domain)
find . -type f \( -name "*.yaml" -o -name "*.yml" -o -name "*.sh" -o -name "*.md" \) \
  -exec sed -i 's/gameapp\.games/YOUR_DOMAIN/g' {} \;
```

**[TODO]** Add automated domain replacement script to repository

## What You Learned

You've successfully set up a complete DevOps development environment:
- **Container Runtime**: Docker for application packaging and deployment
- **Kubernetes Tools**: kubectl and k3d for container orchestration
- **Package Management**: Helm for Kubernetes application distribution
- **Development Tools**: Node.js and jq for automation and scripting
- **System Verification**: Comprehensive environment validation
- **Troubleshooting Skills**: Diagnostic procedures for common issues
- **Domain Configuration**: Critical setup for production deployment

This environment mirrors what professional DevOps engineers use daily. You now have the foundation to build production-grade applications.

---

**Next**: [Chapter 4: Local Multi-Container Development](04-local-compose.md) - Build and test your application locally with Docker Compose
**Previous**: [Chapter 2: Architecture Overview](02-architecture.md) - Understanding the complete system design
