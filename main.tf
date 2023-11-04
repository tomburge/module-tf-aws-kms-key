# Resources
resource "aws_kms_alias" "alias" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.key.key_id
}

resource "aws_kms_key" "key" {
  customer_master_key_spec = var.key_config.key_spec != null ? var.key_config.key_spec : "SYMMETRIC_DEFAULT"
  description              = var.key_config.description != null ? var.key_config.description : "KMS key"
  deletion_window_in_days  = var.key_config.delete_days != null ? var.key_config.delete_days : 7
  enable_key_rotation      = var.key_config.rotation != null ? var.key_config.rotation : true
  is_enabled               = var.key_config.enable != null ? var.key_config.enable : true
  key_usage                = var.key_config.usage != null ? var.key_config.usage : "ENCRYPT_DECRYPT"
  multi_region             = var.key_config.multi_region != null ? var.key_config.multi_region : false
}

resource "aws_kms_key_policy" "policy" {
  key_id = aws_kms_key.key.id
  # policy = data.aws_iam_policy_document.key_policy.json
  policy = var.custom_policy != null ? var.custom_policy : data.aws_iam_policy_document.key_policy.json
}
