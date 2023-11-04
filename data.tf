# Data
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "key_policy" {
  statement {
    actions = [
      "kms:*"
    ]
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  dynamic "statement" {
    for_each = { for target in var.targets : "default" => target if target.target_type == "cw_loggroup" }
    content {
      actions = [
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyPair",
        "kms:GenerateDataKeyPairWithoutPlaintext",
        "kms:ReEncryptFrom",
        "kms:ReEncryptTo"
      ]
      effect    = "Allow"
      resources = ["*"]
      condition {
        test     = "ArnEquals"
        variable = "kms:EncryptionContext:aws:logs:arn"
        values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.name}"]
      }
      principals {
        type        = "Service"
        identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
      }
    }
  }
}
