# AWS backup module for Terraform

This module provides a simple configuration for using [AWS Backup Plans](https://docs.aws.amazon.com/aws-backup/latest/devguide/about-backup-plans.html) with Terraform projects.

By default the backup plan adds rules for the following backup schedules:

| Schedule                     | Retention    |
|:-----------------------------|:-------------|
| Every second hour            | One day      |
| Daily at midnight            | One week     |
| Weekly on Sunday at midnight | Three months |

## Setup instructions

1. Copy the `backup-module` folder to the root of your Terraform config
2. Add a `module` section to your production `main.tf` file, specifying the project and environment names, and any tags you want to apply to the backup plan
3. Create a list of resource ARNs for the AWS resources to be backed up
4. Run `terraform plan` and `terraform apply` to deploy the backup plan
5. Log into your AWS console and check the plan was create successfully

Refer to [`main.example.tf`](./main.example.tf) for details of the module configuration.
