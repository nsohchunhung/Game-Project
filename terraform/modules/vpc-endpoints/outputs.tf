output "s3_endpoint_id" {
  description = "S3 VPC endpoint ID"
  value       = length(aws_vpc_endpoint.s3) > 0 ? aws_vpc_endpoint.s3[0].id : null
}

output "ecr_endpoint_id" {
  description = "ECR DKR VPC endpoint ID"
  value       = length(aws_vpc_endpoint.ecr_dkr) > 0 ? aws_vpc_endpoint.ecr_dkr[0].id : null
}

output "ecr_api_endpoint_id" {
  description = "ECR API VPC endpoint ID"
  value       = length(aws_vpc_endpoint.ecr_api) > 0 ? aws_vpc_endpoint.ecr_api[0].id : null
}

output "ec2_endpoint_id" {
  description = "EC2 VPC endpoint ID"
  value       = length(aws_vpc_endpoint.ec2) > 0 ? aws_vpc_endpoint.ec2[0].id : null
}

output "ssm_endpoint_id" {
  description = "SSM VPC endpoint ID"
  value       = length(aws_vpc_endpoint.ssm) > 0 ? aws_vpc_endpoint.ssm[0].id : null
}

output "cloudwatch_logs_endpoint_id" {
  description = "CloudWatch Logs VPC endpoint ID"
  value       = length(aws_vpc_endpoint.cloudwatch_logs) > 0 ? aws_vpc_endpoint.cloudwatch_logs[0].id : null
}

output "sts_endpoint_id" {
  description = "STS VPC endpoint ID"
  value       = length(aws_vpc_endpoint.sts) > 0 ? aws_vpc_endpoint.sts[0].id : null
}

