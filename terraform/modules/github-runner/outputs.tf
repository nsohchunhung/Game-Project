output "instance_id" {
  description = "GitHub runner instance ID"
  value       = aws_instance.github_runner.id
}

output "private_ip" {
  description = "GitHub runner private IP address"
  value       = aws_instance.github_runner.private_ip
}

output "iam_role_arn" {
  description = "GitHub runner IAM role ARN"
  value       = aws_iam_role.github_runner.arn
}

