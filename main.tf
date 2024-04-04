provider "aws" {
  region = var.region
}

######################CENTRAL CCS######################

# Crear Amazon Kinesis Data Stream
resource "aws_kinesis_stream" "example_stream" {
  name             = "example-stream"
  shard_count      = 1
}

# Crear Amazon Kinesis Data Analytics
resource "aws_kinesis_analytics_application" "example_analytics_app" {
  name            = "example-analytics-app"
  runtime         = "FLINK-1_11"
  service_role    = aws_iam_role.example_role.arn

  inputs {
    name_prefix     = "example-stream"
    kinesis_stream {
      resource_arn = aws_kinesis_stream.example_stream.arn
    }
  }

  outputs {
    kinesis_firehose {
      resource_arn = aws_kinesis_firehose_delivery_stream.example_firehose.arn
    }
  }
}

# Crear Amazon Redshift
resource "aws_redshift_cluster" "example_redshift_cluster" {
  cluster_identifier         = "example-redshift-cluster"
  node_type                  = "dc2.large"
  master_username            = "admin"
  master_password            = "Password123"
  cluster_subnet_group_name  = "default"
}

# Crear Amazon Kinesis Data Firehose
resource "aws_kinesis_firehose_delivery_stream" "example_firehose" {
  name        = "example-firehose"
  destination = "redshift"
  redshift_configuration {
    cluster_jdbcurl      = aws_redshift_cluster.example_redshift_cluster.jdbc_url
    username             = aws_redshift_cluster.example_redshift_cluster.master_username
    password             = aws_redshift_cluster.example_redshift_cluster.master_password
    s3_backup_mode       = "Enabled"
    s3_backup_configuration {
      role_arn = aws_iam_role.example_role.arn
      bucket_arn = aws_s3_bucket.example_bucket.arn
      prefix = "firehose/"
    }
  }
}

# Crear Amazon DynamoDB
resource "aws_dynamodb_table" "example_table" {
  name           = "example-table"
  hash_key       = "id"
  read_capacity  = 5
  write_capacity = 5
  ...
}

# Crear Amazon SQS
resource "aws_sqs_queue" "example_queue" {
  name                       = "example-queue"
  delay_seconds              = 0
  message_retention_seconds  = 86400
  ...
}

# Crear Amazon Lambda
resource "aws_lambda_function" "example_lambda" {
  filename      = "example_lambda.zip"
  function_name = "example-lambda"
  role          = aws_iam_role.example_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
}

# Crear AWS SNS
resource "aws_sns_topic" "example_topic" {
  name = "example-topic"
}

# Crear una suscripción SNS para el envío de correos electrónicos
resource "aws_sns_topic_subscription" "example_subscription" {
  topic_arn = aws_sns_topic.example_topic.arn
  protocol  = "email"
  endpoint  = "email@example.com"
}

# Crear Amazon Kinesis Video Stream
resource "aws_kinesis_video_stream" "example_stream" {
  name = "example-stream"
  retention_period_hours = 24
}


# Crear políticas IAM
resource "aws_iam_policy" "example_policy" {
  name        = "example-policy"
  description = "Example IAM policy"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "kinesis:*",
          "redshift:*",
          "firehose:*",
          "dynamodb:*",
          "sqs:*",
          "lambda:*",
          "sns:*",
        ],
        Resource  = "*",
      },
    ],
  })
}

# Asociar política IAM al rol
resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = "arn:aws:iam::123456789012:role/example-role"
  policy_arn = aws_iam_policy.example_policy.arn
}

# Crear CloudTrail
resource "aws_cloudtrail" "example_trail" {
  name               = "example-trail"
  s3_bucket_name     = "example-bucket"
  enable_log_file_validation = true
}

# Crear CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "example_dashboard" {
  dashboard_name = "example-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type    = "metric"
        x       = 0
        y       = 0
        width   = 12
        height  = 6
        properties = {
          metrics = [
            [ "AWS/Kinesis", "IncomingRecords", "StreamName", "example-stream" ],
            [ ".", "OutgoingRecords", ".", "." ],
          ]
          period = 300
          title  = "Kinesis Metrics"
        }
      },
      {
        type    = "metric"
        x       = 0
        y       = 6
        width   = 12
        height  = 6
        properties = {
          metrics = [
            [ "AWS/Redshift", "Queries", "ClusterIdentifier", "example-cluster" ],
            [ ".", "CPUCreditBalance", ".", "." ],
          ]
          period = 300
          title  = "Redshift Metrics"
        }
      },
    ]
  })
}

######################PLAN PLUS######################

# Crea un bucket en S3
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # Cambia esto por un nombre único para tu bucket
  acl    = "private"
}

# Crea un CloudFront distribution
resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_id   = "S3-Bucket-Origin"
  }

  default_cache_behavior {
    target_origin_id = "S3-Bucket-Origin"
    viewer_protocol_policy = "allow-all"
  }

  # Agrega configuraciones adicionales según tus necesidades
}

# Crea un API Gateway
resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my-api"
  description = "My API Gateway"
}

# Crea un Network Load Balancer (NLB)
resource "aws_lb" "my_nlb" {
  name               = "my-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["subnet-12345678", "subnet-87654321"]
}

# Crea un Fargate Cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}

# Crea una base de datos Aurora
resource "aws_rds_cluster" "my_cluster" {
  cluster_identifier      = "my-cluster"
  engine                  = "aurora"
  engine_version          = "5.6.10a"
  database_name           = "my_database"
  master_username         = "admin"
  master_password         = "password" 
  skip_final_snapshot     = true
  backup_retention_period = 7
}


