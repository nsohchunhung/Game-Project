# Terraform Backend Setup Guide

This guide explains how to set up Terraform remote state in S3 with automatic initialization.

## Overview

The Terraform backend stores state in S3 with:
- **S3 Bucket**: Encrypted state files
- **DynamoDB Table**: State locking (prevents concurrent modifications)
- **KMS Key**: Encryption at rest
- **Auto IP Detection**: Automatically updates bastion access

## Quick Start

### 1. Run Backend Initialization Script

```bash
./scripts/terraform/init-backend.sh
```

This script automatically:
- ✅ Creates S3 bucket for state
- ✅ Creates DynamoDB table for locking
- ✅ Creates KMS key for encryption
- ✅ Detects your IP address
- ✅ Updates terraform.tfvars with your IP
- ✅ Creates backend-config.hcl files
- ✅ Creates AWS key pair for bastion

### 2. Initialize Terraform

```bash
cd terraform/environments/prod
terraform init -backend-config=backend-config.hcl
```

### 3. Deploy

```bash
terraform plan
terraform apply
```

## What the Script Does

### Step 1: S3 Bucket Creation
- Creates bucket: `devops-home-lab-terraform-state-{random}`
- Enables versioning
- Blocks public access
- Enables encryption with KMS

### Step 2: DynamoDB Table
- Creates table: `devops-home-lab-terraform-locks`
- Pay-per-request billing (cost-effective)
- Used for state locking

### Step 3: KMS Key
- Creates key: `alias/devops-home-lab-terraform-state`
- Used for S3 encryption
- Enables key rotation

### Step 4: IP Detection
- Automatically detects your public IP
- Updates `bastion_allowed_cidr_blocks` in terraform.tfvars
- Format: `["YOUR_IP/32"]`

### Step 5: Backend Config Files
- Creates `backend-config.hcl` for each environment
- Includes bucket name, KMS key, DynamoDB table

### Step 6: AWS Key Pair
- Creates key pair: `devops-home-lab-bastion`
- Saves private key: `devops-home-lab-bastion.pem`
- Sets permissions: `chmod 400`

## Manual Setup (If Script Fails)

### Create S3 Bucket

```bash
BUCKET_NAME="devops-home-lab-terraform-state-$(date +%s)"
aws s3 mb s3://${BUCKET_NAME} --region us-east-1
aws s3api put-bucket-versioning \
  --bucket ${BUCKET_NAME} \
  --versioning-configuration Status=Enabled
```

### Create DynamoDB Table

```bash
aws dynamodb create-table \
  --table-name devops-home-lab-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

### Create KMS Key

```bash
KMS_KEY_ID=$(aws kms create-key \
  --description "DevOps Home Lab Terraform State Encryption" \
  --query 'KeyMetadata.KeyId' --output text)

aws kms create-alias \
  --alias-name alias/devops-home-lab-terraform-state \
  --target-key-id ${KMS_KEY_ID}
```

### Create Backend Config

```bash
cat > terraform/environments/prod/backend-config.hcl <<EOF
bucket         = "${BUCKET_NAME}"
key            = "prod/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
kms_key_id     = "alias/devops-home-lab-terraform-state"
dynamodb_table = "devops-home-lab-terraform-locks"
EOF
```

## Cost

- **S3 Storage**: ~$0.023/GB/month (minimal for state files)
- **DynamoDB**: Pay-per-request (~$0.25 per million requests)
- **KMS**: $1/month per key
- **Total**: ~$1-2/month

## Security

- ✅ State encrypted at rest (KMS)
- ✅ State encrypted in transit (HTTPS)
- ✅ Versioning enabled (recover deleted state)
- ✅ Public access blocked
- ✅ State locking (prevents conflicts)

## Troubleshooting

### Error: "Bucket already exists"
**Solution**: Script will use existing bucket automatically

### Error: "Access Denied"
**Solution**: Check IAM permissions for S3, DynamoDB, KMS

### Error: "IP detection failed"
**Solution**: Script uses `0.0.0.0/0` as fallback - manually update terraform.tfvars

### Error: "Backend initialization failed"
**Solution**: Run script with `set -x` to see detailed output

## Best Practices

1. **Never commit backend-config.hcl** - Contains bucket names
2. **Use separate buckets per environment** - Or separate keys
3. **Enable versioning** - Recover deleted state
4. **Rotate KMS keys** - Enable automatic rotation
5. **Restrict IP access** - Update bastion_allowed_cidr_blocks regularly

## Next Steps

After backend setup:
1. ✅ Initialize Terraform: `terraform init -backend-config=backend-config.hcl`
2. ✅ Plan deployment: `terraform plan`
3. ✅ Apply infrastructure: `terraform apply`
4. ✅ Verify state: `terraform state list`

