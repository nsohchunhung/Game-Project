# GitHub Runner Access Guide

This guide explains how to access and manage the self-hosted GitHub Actions runner deployed on AWS EC2.

## Overview

The GitHub runner is deployed in a **private subnet** in the hub VPC, which means:
- ✅ No public IP address (more secure)
- ✅ Accessible only via bastion host or AWS Systems Manager (SSM)
- ✅ Outbound access to GitHub API for job execution

## Access Methods

### Method 1: Via Bastion Host (Recommended)

1. **SSH to bastion host:**
   ```bash
   ssh -i your-key.pem ec2-user@<bastion-public-ip>
   ```

2. **From bastion, SSH to GitHub runner:**
   ```bash
   # Get runner private IP from Terraform output
   terraform output github_runner_private_ip
   
   # SSH to runner (using the same key or SSM)
   ssh ec2-user@<runner-private-ip>
   ```

### Method 2: AWS Systems Manager (SSM) Session Manager (Easiest)

The runner has SSM agent installed, so you can use AWS Session Manager:

1. **From your local machine:**
   ```bash
   # Install Session Manager plugin (if not already installed)
   # macOS:
   brew install --cask session-manager-plugin
   
   # Linux:
   # Download from: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
   ```

2. **Start a session:**
   ```bash
   # Get runner instance ID
   aws ec2 describe-instances \
     --filters "Name=tag:Name,Values=devops-home-lab-prod-github-runner" \
     --query 'Reservations[0].Instances[0].InstanceId' \
     --output text
   
   # Start SSM session
   aws ssm start-session --target <instance-id>
   ```

3. **You're now connected!** No SSH keys needed.

### Method 3: Port Forwarding (For debugging)

If you need to access services on the runner:

```bash
# Via bastion
ssh -i your-key.pem -L 8080:localhost:8080 ec2-user@<bastion-ip>
```

## Verifying Runner Status

### From GitHub UI

1. Go to your repository
2. Navigate to **Settings** → **Actions** → **Runners**
3. You should see your runner listed with status "Online"

### From Runner Instance

```bash
# SSH or SSM into runner
cd /home/ec2-user/actions-runner

# Check runner status
./svc.sh status

# View runner logs
tail -f _diag/Runner_*.log
```

## Common Tasks

### View Runner Logs

```bash
# SSH/SSM into runner
cd /home/ec2-user/actions-runner/_diag
tail -f Runner_*.log
```

### Restart Runner Service

```bash
# SSH/SSM into runner
cd /home/ec2-user/actions-runner
./svc.sh stop
./svc.sh start
./svc.sh status
```

### Reconfigure Runner

If you need to change runner configuration:

```bash
# SSH/SSM into runner
cd /home/ec2-user/actions-runner

# Stop service
./svc.sh stop
./svc.sh uninstall

# Remove old configuration
rm -rf .runner

# Get new token from GitHub:
# Settings → Actions → Runners → New self-hosted runner

# Reconfigure
./config.sh --url https://github.com/YOUR_ORG/YOUR_REPO \
  --token YOUR_NEW_TOKEN \
  --labels self-hosted,linux,x64,aws \
  --name devops-home-lab-prod-github-runner \
  --work _work \
  --replace \
  --unattended

# Reinstall service
./svc.sh install ec2-user
./svc.sh start
```

### Update Runner Software

```bash
# SSH/SSM into runner
cd /home/ec2-user/actions-runner

# Stop service
./svc.sh stop

# Download latest runner
RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.tag_name')
curl -o actions-runner-linux-x64-${RUNNER_VERSION#v}.tar.gz -L \
  https://github.com/actions/runner/releases/download/${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION#v}.tar.gz

# Backup current installation
cp -r . ../actions-runner-backup

# Extract new version
tar xzf actions-runner-linux-x64-${RUNNER_VERSION#v}.tar.gz --strip-components=1

# Start service
./svc.sh start
```

## Troubleshooting

### Runner Not Appearing in GitHub

1. **Check runner logs:**
   ```bash
   tail -f /home/ec2-user/actions-runner/_diag/Runner_*.log
   ```

2. **Verify network connectivity:**
   ```bash
   # From runner, test GitHub API access
   curl -H "Authorization: token YOUR_TOKEN" https://api.github.com
   ```

3. **Check security group:**
   - Runner needs outbound HTTPS (443) to GitHub
   - Verify security group allows this

### Runner Offline

1. **Check service status:**
   ```bash
   ./svc.sh status
   ```

2. **Restart service:**
   ```bash
   ./svc.sh restart
   ```

3. **Check system resources:**
   ```bash
   df -h  # Check disk space
   free -h  # Check memory
   ```

### Jobs Not Running

1. **Check runner labels match workflow:**
   ```yaml
   # In your workflow file
   runs-on: self-hosted  # Must match runner labels
   ```

2. **Verify runner has required tools:**
   ```bash
   # From runner
   docker --version
   kubectl version
   helm version
   aws --version
   ```

### Cannot Access Runner

1. **Verify instance is running:**
   ```bash
   aws ec2 describe-instances \
     --filters "Name=tag:Name,Values=devops-home-lab-prod-github-runner" \
     --query 'Reservations[0].Instances[0].State.Name'
   ```

2. **Check security groups:**
   - Bastion should allow SSH from your IP
   - Runner should allow SSH from bastion security group

3. **Use SSM as alternative:**
   ```bash
   aws ssm start-session --target <instance-id>
   ```

## Security Best Practices

1. **Restrict bastion access:**
   - Only allow your IP in `bastion_allowed_cidr_blocks`
   - Use VPN or bastion for access

2. **Use SSM instead of SSH:**
   - No SSH keys to manage
   - All sessions logged in CloudTrail
   - More secure

3. **Rotate runner token regularly:**
   - Generate new token from GitHub
   - Reconfigure runner with new token

4. **Monitor runner activity:**
   - Check GitHub Actions logs
   - Review CloudWatch logs for runner instance

## Getting Runner Information

### From Terraform Output

```bash
cd terraform/environments/prod
terraform output github_runner_private_ip
```

### From AWS CLI

```bash
# Get instance ID
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=devops-home-lab-prod-github-runner" \
  --query 'Reservations[0].Instances[0].[InstanceId,PrivateIpAddress,State.Name]' \
  --output table

# Get instance details
aws ec2 describe-instances \
  --instance-ids <instance-id> \
  --query 'Reservations[0].Instances[0]' \
  --output json
```

## Next Steps

- [ ] Set up monitoring for runner health
- [ ] Configure automatic runner updates
- [ ] Set up alerts for runner failures
- [ ] Document runner maintenance procedures

