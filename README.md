# ccs-infraestructura-terraform-educativo
Este repositorio contiene el código de Terraform utilizado para diseñar la infraestructura de la Compañía Colombiana de Seguimiento de Vehículos (CCS). El código se proporciona con fines educativos.

## Getting Started

To get started with this template, you will need to have Terraform installed on your local machine. You can download the latest version of Terraform from the official [Terraform website](https://www.terraform.io/) .

## Prerequisites

Before you can use this Terraform template, you will need to have the following:

1. An AWS account
2. AWS access credentials and profile configuration
3. Create S3 bucket for remote state
3. A text editor or IDE to modify the Terraform files.

## AWS Profile Settings

To ensure which AWS account you will be provisioning the resources in this template, note that you can specify the AWS profile to use as an environment variable. In this case, it shows how to apply it for an AWS SSO profile:

1. Make sure you have configured the AWS SSO profile in your CLI. If you don't have it yet, you can configure it by running the following command and indicate the access data.

	`aws configure sso --profile <nombre_perfil>`
   

2. Verify that the AWS SSO section has been created correctly in the ~/.aws/config file. It should have a structure similar to this:

```
[profile <nombre_perfil>]

sso_start_url = <URL_inicio_SSO>

sso_region = <region_SSO>

sso_account_id = <ID_cuenta>

sso_role_name = <nombre_rol>

region = <region_preferida>

output = json
```


3. Set the AWS_PROFILE environment variable to use the AWS SSO profile. In your terminal, run the following commands before running the Terraform commands:

**On Unix/Linux/macOS systems:**
   `export AWS_PROFILE=<nombre_perfil>`

**On Windows (PowerShell):**
   `$env:AWS_PROFILE = "<nombre_perfil>"`

**On Windows (CMD):**
   `set AWS_PROFILE=<nombre_perfil>`
   
   
4. Make sure you are logged in to AWS SSO before running terraform init. If your AWS SSO session timed out while you were working with Terraform, you'll need to sign in again before running the terraform command. You can do this by running the following command in your terminal:


	`aws sso login --profile <nombre_perfil>`


## Installing

1. Clone this repository to your local machine:

	`git clone https://github.com/jguerrap/ccs-infraestructura-terraform-educativo.git`


2. Navigate to the cloned repository:

	`cd <your_repository_name>`


3. Set the environment variable to indicate the S3 bucket name you will use to persist the remote state of terraform:

	`export TFSTATE_BUCKET=<BUCKET_NAME>`


4. Initialize the Terraform workspace:

	`terraform init -backend-config="bucket=${TFSTATE_BUCKET}"`


5. Review the changes Terraform will make:

	`terraform plan`


6. Apply the changes:

	`terraform apply`


## Customization

A new properties file can be added to create the organization and account structure of a new client by adding a properties file equivalent to **"project-environment.tfvars"**

## Company Information

This template was developed for Consultec-ti.

## Terraform Configuration

The following resources will be created by this Terraform configuration:

**aws_cloudtrail:** aws_cloudtrail example_trail

**aws_cloudwatch_dashboard:** aws_cloudwatch_dashboard example_dashboard

**aws_dynamodb_table:** aws_dynamodb_table example_table

**aws_iam_policy:** aws_iam_policy example_policy

**aws_iam_role_policy_attachment:** aws_iam_role_policy_attachment example_policy_attachment

**aws_kinesis_analytics_application:** aws_kinesis_analytics_application example_analytics_app

**aws_kinesis_firehose_delivery_stream:** aws_kinesis_firehose_delivery_stream example_firehose

**aws_kinesis_stream:** aws_kinesis_stream example_stream

**aws_kinesis_video_stream:** aws_kinesis_video_stream example_stream

**aws_lambda_function:** aws_lambda_function example_lambda

**aws_redshift_cluster:** aws_redshift_cluster example_redshift_cluster

**aws_s3_bucket:** aws_s3_bucket my_bucket

**aws_sns_topic:** aws_sns_topic example_topic

**aws_sns_topic_subscription:** aws_sns_topic_subscription example_subscription

**aws_sqs_queue:** aws_sqs_queue example_queue

**aws_ecs_cluster:** aws_ecs_cluster my_cluster

**aws_api_gateway_rest_api:** aws_api_gateway_rest_api my_api

**aws_lb:** aws_lb my_nlb

**aws_rds_cluster:** aws_rds_cluster my_cluster

**aws_cloudfront_distribution:** aws_cloudfront_distribution my_distribution

## Authors

Juan R Guerra - [juanrguerrap@hotmail.com](juanrguerrap@hotmail.com)


## License
This project is licensed under the MIT License - see the LICENSE.md file for details.