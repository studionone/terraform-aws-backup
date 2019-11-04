# AWS backup module for Terraform

This module provides a simple configuration for using [AWS Backup Plans][1] with Terraform projects.

By default the module creates backup plan rules for the following schedules:

| Schedule                     | Retention    |
|:-----------------------------|:-------------|
| Every second hour            | One day      |
| Daily at midnight            | One week     |
| Weekly on Sunday at midnight | Three months |

Note that all times are specified in UTC. To change the schedule time, refer to the [configuration options](#configuration-options) below.

## Supported resources

The following AWS resources are supported by AWS backup plans:

- EFS file systems
- DynamoDB tables
- EBS volumes
- RDS databases (except Amazon Aurora)
- Storage Gateway volumes

For an up-to-date list of supported resources, refer to the AWS Backup Plans [documentation][2].

## Setup instructions

1. Add a `module` section to your production `main.tf` file
2. Specify the `env`, `project` and `resources` variables to configure the backup
3. Run `terraform init`, `terraform plan` and `terraform apply` to deploy the backup plan
4. Log into your AWS console and check the plan was created successfully

### Configuration options

- **env**: *Required* The project environment, for use in backup plan names 
- **project**: *Required* The project name, for use in backup plan names
- **resources**: *Required* A list of ARNs for resources to be backed up
- **tags**: A map of tags to apply to the backup plan, vaults etc
- **hourly_period**: The period in hours used for the hourly rule schedule. Defaults to 2
- **daily_time**: The UTC hour to perform backups for daily and weekly rule schedules. Defaults to 0
- **max_retention**: The number of days to keep weekly backups before deleting. Defaults to 90

Full details of each variable can be found in the [variables file](./variables.tf).

### Example configuration

```hcl
module "backups" {
  source = "github.com/studionone/terraform-aws-backup?ref=v1.0.0"

  # Required variables
  env = "prod"
  project = "example-project"
  resources = module.deployment.backup_resource_arns

  # Optional variables
  tags = module.deployment.common_tags
  hourly_period = 12
  daily_time = 14 # This is in UTC
  max_retention = 30
}
```

[1]: https://docs.aws.amazon.com/aws-backup/latest/devguide/about-backup-plans.html
[2]: https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#supported-resources
