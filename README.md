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

**aws_codeartifact_repository:** Creates the CodeArtifact repository.

**aws_ecr_repository:** Creates the ECR repository.

## Authors

Juan R Guerra - [juanrguerrap@hotmail.com](juanrguerrap@hotmail.com)


## License
This project is licensed under the MIT License - see the LICENSE.md file for details.