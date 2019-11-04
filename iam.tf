resource "aws_iam_role" "backup_role" {
  name = "${var.project}-${var.env}-backup-role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role_policy.json
}

data "aws_iam_policy_document" "backup_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "backup_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role = "${aws_iam_role.backup_role.name}"
}
