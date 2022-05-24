resource "aws_iam_role" "iam_role" {
  name = "${var.model_name}-sagemaker-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "${var.model_name}-sagemaker-iam-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "cloudwatch:PutMetricData",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:DescribeLogStreams",
            "s3:GetObject",
            "s3:PutObject",
            "s3:ListBucket",
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage"
          ],
          Resource = "*"
        }
      ]
    })
  }
}

data "aws_sagemaker_prebuilt_ecr_image" "sagemaker_prebuilt_ecr_image" {
  repository_name = var.repository_name
  image_tag       = "1.9.1-transformers${var.transformers_version}-cpu-py38-ubuntu20.04"
}

resource "aws_sagemaker_model" "sagemaker_model" {
  name               = "${var.model_name}-sagemaker-model"
  execution_role_arn = aws_iam_role.iam_role.arn

  primary_container {
    image = data.aws_sagemaker_prebuilt_ecr_image.sagemaker_prebuilt_ecr_image.registry_path
    environment = {
      HF_TASK     = var.hf_task
      HF_MODEL_ID = var.hf_model_id
    }
  }
}

resource "aws_sagemaker_endpoint_configuration" "sagemaker_endpoint_configuration" {
  name = "${var.model_name}-sagemaker-endpoint-configuration"

  production_variants {
    variant_name           = "AllTraffic"
    model_name             = aws_sagemaker_model.sagemaker_model.name
    initial_instance_count = var.instance_count
    instance_type          = var.instance_type
  }
}

resource "aws_sagemaker_endpoint" "sagemaker_endpoint" {
  name = "${var.model_name}-sagemaker-endpoint"

  endpoint_config_name = aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.name
}
