output "model_endpoint_name" {
  value       = aws_sagemaker_endpoint.sagemaker_endpoint.name
}

output "model_endpoint_arn" {
  value       = aws_sagemaker_endpoint.sagemaker_endpoint.arn
}
