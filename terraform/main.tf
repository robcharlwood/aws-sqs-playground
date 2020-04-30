provider "aws" {
  region  = "eu-west-2"
  profile = "aws-terraform-personal"
  version = "~> 2.59.0"
}

resource "aws_sqs_queue" "sqs_queue" {
  name                      = "sqs-queue"
  message_retention_seconds = 43200  # 12 hours
}
