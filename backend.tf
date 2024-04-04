terraform {
  backend "s3" {
    bucket         = "nombre-del-bucket"
    key            = "infraestructura/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}