resource "aws_backup_plan" "backup_plan" {
  name = "${var.project}-${var.env}-backup-plan"
  tags = var.tags

  rule {
    rule_name = "${var.project}-${var.env}-backup-hourly-rule"
    target_vault_name = aws_backup_vault.hourly_backup_vault.name

    # Every second hour on the hour; keep for one day
    schedule = "cron(0 */2 * * ? *)"
    lifecycle {
      delete_after = 1
    }
  }

  rule {
    rule_name = "${var.project}-${var.env}-backup-daily-rule"
    target_vault_name = aws_backup_vault.daily_backup_vault.name

    # Every day at midnight; keep for one week
    schedule = "cron(0 0 * * ? *)"
    lifecycle {
      delete_after = 7
    }
  }

  rule {
    rule_name = "${var.project}-${var.env}-backup-weekly-rule"
    target_vault_name = aws_backup_vault.weekly_backup_vault.name

    # Every Sunday at midnight; keep for three months
    schedule = "cron(0 0 ? * 1 *)"
    lifecycle {
      delete_after = 90
    }
  }
}

resource "aws_backup_vault" "hourly_backup_vault" {
  name = "${var.project}-${var.env}-hourly-backups"
  tags = var.tags
}

resource "aws_backup_vault" "daily_backup_vault" {
  name = "${var.project}-${var.env}-daily-backups"
  tags = var.tags
}

resource "aws_backup_vault" "weekly_backup_vault" {
  name = "${var.project}-${var.env}-weekly-backups"
  tags = var.tags
}

resource "aws_backup_selection" "backup_selection" {
  name = "${var.project}-${var.env}-backup-selection"
  plan_id = aws_backup_plan.backup_plan.id
  iam_role_arn = aws_iam_role.backup_role.arn

  resources = var.resources
}
