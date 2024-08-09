# S3 Log Monitoring System with CloudFront and Terraform

This repository contains Terraform modules to set up a system for monitoring missing images in an Amazon S3 bucket using CloudFront, SQS, SNS, Lambda, and Logstash on EC2.

## Table of Contents

- [Overview](#overview)
- [Terraform Modules](#terraform-modules)
  - [S3 Buckets](#1-s3-buckets)
  - [CloudFront Distribution](#2-cloudfront-distribution)
  - [SNS Topic](#3-sns-topic)
  - [SQS Queue](#4-sqs-queue)
  - [Lambda Function](#5-lambda-function)
  - [Logstash EC2 Instance](#6-logstash-ec2-instance)
- [Usage](#usage)
  - [Initialize Terraform](#initialize-terraform)
  - [Apply Terraform Configuration](#apply-terraform-configuration)
- [Post-Deployment Configuration](#post-deployment-configuration)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository automates the deployment of a monitoring system that detects and handles missing images hosted in an S3 bucket. The system is designed to:

- Store images in one S3 bucket and logs in another.
- Serve images through a CloudFront distribution.
- Detect missing images using Logstash and send notifications through SNS.
- Utilize SQS to queue messages for processing by a Lambda function.

## Terraform Modules

### 1. S3 Buckets

Creates two S3 buckets: one for storing images and another for storing access logs.

```hcl
module "s3_buckets" {
  source            = "./modules/s3"
  image_bucket_name = "my-image-bucket"  # Name of the image bucket
  log_bucket_name   = "my-log-bucket"    # Name of the log bucket
}
