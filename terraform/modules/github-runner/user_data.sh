#!/bin/bash
set -e

# Install required packages
yum update -y
yum install -y docker git jq curl unzip

# Start Docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install AWS CLI v2
if ! command -v aws &> /dev/null; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install
fi

# Install GitHub Actions Runner
cd /home/ec2-user
mkdir actions-runner && cd actions-runner

# Download latest runner
RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.tag_name')
curl -o actions-runner-linux-x64-${RUNNER_VERSION#v}.tar.gz -L https://github.com/actions/runner/releases/download/${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION#v}.tar.gz
tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION#v}.tar.gz

# Configure runner
./config.sh --url https://github.com/${github_repository} --token ${github_token} --labels ${github_labels} --name ${runner_name} --work _work --replace --unattended

# Install runner as service
./svc.sh install ec2-user
./svc.sh start

# Log runner status
./svc.sh status

