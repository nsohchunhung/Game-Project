# DevOps Tutorial: Set Up Your Development Environment

*Install all the tools you need to build production-grade applications with Kubernetes*

## 🎯 **What You'll Learn**

By the end of this setup, you'll have:
- **Docker** running for containerization
- **Kubernetes tools** (kubectl, k3d) for cluster management
- **Development tools** (Node.js, jq) for application building
- **Package managers** (Helm) for Kubernetes applications

## ⏱️ **Time Required: 15-30 minutes**

## Why This Matters

Proper tool installation prevents hours of troubleshooting later. Think of this as setting up your workshop before building a house. You need the right tools to build something that actually works.

**What this means for you**: These are the same tools professional DevOps engineers use daily. Learning them now means you're building real-world skills.

## Do This

### Step 1: Install Required Tools

**For macOS (Recommended path):**
```bash
# Install all tools at once using Homebrew
brew install docker docker-compose kubectl k3d helm nodejs jq

# Start Docker Desktop (required for container operations)
# Download from: https://www.docker.com/products/docker-desktop
```

**Expected Output:**
```bash
==> Installing docker
==> Installing docker-compose
==> Installing kubectl
==> Installing k3d
==> Installing helm
==> Installing nodejs
==> Installing jq
==> Summary
🍺  /opt/homebrew/Cellar now contains:
  docker, docker-compose, kubectl, k3d, helm, nodejs, jq
```

**For Linux (Ubuntu/Debian):**
```bash
# Update your system first
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker  # Apply group changes immediately
```

**Expected Output:**
```bash
Get:1 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1,234 kB]
...
Reading package lists... Done
Building dependency tree... Done
docker.io is already the newest version (20.10.21-0ubuntu1~20.04.2).
docker-compose is already the newest version (1.25.0-1).
```

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl

# Install k3d (lightweight Kubernetes)
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

ℹ️ **Side Note:** k3d is a lightweight Kubernetes distribution that runs inside Docker containers. It's perfect for development and testing because it's fast to start, uses minimal resources, and provides a real Kubernetes experience without the overhead of full cluster management.

```bash
# Install Helm (Kubernetes package manager)
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs jq
```

### Step 2: Verify Tools Are Installed

```bash
# Check all tools are properly installed
docker --version        # Should show: Docker version 20.0+
kubectl version --client # Should show: Client Version v1.28+
k3d version            # Should show: k3d version v5.6+
helm version           # Should show: version.BuildInfo
node --version         # Should show: v18+
npm --version          # Should show: 8.0+
jq --version           # Should show: jq-1.6+
```

**Expected Output:**
```bash
Docker version 20.10.21, build 20.10.21-0ubuntu1~20.04.2
Client Version: version.Info{Major:"1", Minor:"28", GitVersion:"v1.28.0", GitCommit:"a6eaaf4d6efc7a96940d2d4247e7206c91e14be7", GitTreeState:"clean", BuildDate:"2023-08-28T16:03:32Z", GoVersion:"go1.20.5", Compiler:"gc", Platform:"linux/amd64"}
k3d version v5.6.0
version.BuildInfo{Version:"v3.12.3", GitCommit:"3a31588be33fe7a89b61ea5e2022f9e2a8f2c5c7", GitTreeState:"clean", GoVersion:"go1.20.10"}
v18.17.1
8.19.4
jq-1.6
```

### Step 3: Check System Resources

```bash
# Check Docker daemon status
docker info

# Check available memory (macOS)
vm_stat

# Check disk space
df -h
```

**Expected Output:**
```bash
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Docker Buildx (Docker Inc., v0.10.4)
  compose: Docker Compose (Docker Inc., v2.17.2)
  scan: Docker Scan (Docker Inc., v0.23.0)

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 20.10.21
 Storage Driver: overlay2
 Total Memory: 4.096GiB
```

### Step 4: Test Docker Functionality

```bash
# Test Docker is working
docker run hello-world
```

**Expected Output:**
```bash
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:7d0ee538c6de6c5f71c0b0c83f6c466e77e7f1b5c8b5c8b5c8b5c8b5c8b5c8b5
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
```

## You Should See...

**Tool Versions:**
```bash
Docker version 20.0+
Client Version: v1.28+
k3d version v5.6+
version.BuildInfo{Version:v3.18+}
v18+
8.0+
jq-1.6+
```

**Docker Info:**
```bash
Server:
 Containers: 0
 Server Version: 20.0+
 Total Memory: 4GB+
 Name: colima (or docker-desktop)
```

**System Resources:**
```bash
Filesystem: At least 10GB available
Memory: At least 4GB available
```

## ✅ Checkpoint

Your environment is ready when:
- ✅ All 7 required tools show version numbers
- ✅ Docker daemon is running and accessible
- ✅ At least 4GB RAM available
- ✅ At least 10GB disk space available
- ✅ No permission or PATH errors
- ✅ `docker run hello-world` succeeds

## If It Fails

### Symptom: Docker permission errors
**Cause:** User not in docker group
**Command to confirm:** `docker run hello-world`
**Fix:**
```bash
# Add user to docker group (Linux)
sudo usermod -aG docker $USER
newgrp docker

# For macOS, ensure Docker Desktop is running
open -a Docker
```

### Symptom: kubectl command not found
**Cause:** kubectl not in PATH or not installed
**Command to confirm:** `which kubectl`
**Fix:**
```bash
# Reinstall kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl

# Verify installation
kubectl version --client
```

### Symptom: k3d cluster creation fails
**Cause:** Docker not running or insufficient resources
**Command to confirm:** `docker info`
**Fix:**
```bash
# Ensure Docker is running
docker info

# Check available memory
docker system df

# Restart Docker if needed
# macOS: Restart Docker Desktop
# Linux: sudo systemctl restart docker
```

## 💡 **Reset/Rollback Commands**

If you need to start over or fix issues:

```bash
# Remove specific tools (macOS)
brew uninstall docker docker-compose kubectl k3d helm nodejs jq

# Remove specific tools (Linux)
sudo apt-get remove docker.io docker-compose kubectl
sudo rm -f /usr/local/bin/k3d /usr/local/bin/helm /usr/local/bin/kubectl

# Clean Docker completely
docker system prune -a --volumes

# Reset Docker Desktop (macOS)
# Quit Docker Desktop, delete ~/Library/Containers/com.docker.docker
```

## What You Learned

You've successfully set up a production-ready development environment with:
- **Container runtime** (Docker) for application packaging
- **Kubernetes tools** (kubectl, k3d) for cluster management
- **Package management** (Helm) for Kubernetes applications
- **Development tools** (Node.js, jq) for application development
- **Resource verification** to ensure sufficient capacity

## Professional Skills Gained

- **Environment provisioning** best practices
- **Tool version management** and compatibility
- **System resource assessment** for container workloads
- **Cross-platform tool installation** (macOS/Linux)
- **Docker daemon configuration** and troubleshooting

---

*Prerequisites milestone completed successfully. All tools installed and verified, ready for [02-compose.md](02-compose.md).*
