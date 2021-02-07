resource "aws_kms_key" "app" {
  description             = "App KMS key"
  deletion_window_in_days = 10
  tags                    = local.tags
}