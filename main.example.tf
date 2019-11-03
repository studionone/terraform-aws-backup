provider "aws" {
  # ...
}

terraform {
  # ...
}

# Main deployment module
module "deployment" {
  # ... 
}

# Backup module
module "backups" {
  source = "../backup-module"
  # These variables are used for naming the backup plan, vaults etc
  env = "prod"
  project = "example-project"
  # A map of tags to apply to the backup plan
  tags = []
  # A list of ARNs for resources to be backed up. Here, this
  # is provided by an output from the deployment module
  resources = module.deployment.backup_resource_arns
}
