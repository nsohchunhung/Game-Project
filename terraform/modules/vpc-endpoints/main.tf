terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# VPC Endpoint for S3 (Gateway endpoint - no ENI needed)
# S3 gateway endpoint needs routes in ALL route tables
resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids  # All route tables (private + public if needed)

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-s3-endpoint"
    }
  )
}

# VPC Endpoint for ECR API (Interface endpoint)
resource "aws_vpc_endpoint" "ecr_api" {
  count = var.enable_ecr_api_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-ecr-api-endpoint"
    }
  )
}

# VPC Endpoint for ECR DKR (Interface endpoint)
resource "aws_vpc_endpoint" "ecr_dkr" {
  count = var.enable_ecr_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-ecr-dkr-endpoint"
    }
  )
}

# VPC Endpoint for EC2 (Interface endpoint)
resource "aws_vpc_endpoint" "ec2" {
  count = var.enable_ec2_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-ec2-endpoint"
    }
  )
}

# VPC Endpoint for EC2 Messages (Interface endpoint)
resource "aws_vpc_endpoint" "ec2_messages" {
  count = var.enable_ec2_messages_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-ec2-messages-endpoint"
    }
  )
}

# VPC Endpoint for SSM (Interface endpoint)
resource "aws_vpc_endpoint" "ssm" {
  count = var.enable_ssm_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-ssm-endpoint"
    }
  )
}

# VPC Endpoint for SSM Messages (Interface endpoint)
resource "aws_vpc_endpoint" "ssm_messages" {
  count = var.enable_ssm_messages_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-ssm-messages-endpoint"
    }
  )
}

# VPC Endpoint for CloudWatch Logs (Interface endpoint)
resource "aws_vpc_endpoint" "cloudwatch_logs" {
  count = var.enable_cloudwatch_logs_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-cloudwatch-logs-endpoint"
    }
  )
}

# VPC Endpoint for CloudWatch Metrics (Interface endpoint)
resource "aws_vpc_endpoint" "cloudwatch_metrics" {
  count = var.enable_cloudwatch_metrics_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.monitoring"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-cloudwatch-metrics-endpoint"
    }
  )
}

# VPC Endpoint for STS (Interface endpoint)
resource "aws_vpc_endpoint" "sts" {
  count = var.enable_sts_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.sts"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-sts-endpoint"
    }
  )
}

# VPC Endpoint for Autoscaling (Interface endpoint)
resource "aws_vpc_endpoint" "autoscaling" {
  count = var.enable_autoscaling_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.autoscaling"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_id}-autoscaling-endpoint"
    }
  )
}

# Data source for current region
data "aws_region" "current" {}

