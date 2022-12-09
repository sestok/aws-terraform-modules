resource "aws_ssm_parameter" "ssm_parameter" {
    name        = var.name
    value       = var.value
    description = var.description
    type        = "SecureString"
    key_id      = var.key_id
    tier        = var.tier
    tags        = var.tags
}
