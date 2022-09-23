output "name" {
  value = aws_secretsmanager_secret.this.name
}
output "arn" {
  value = aws_secretsmanager_secret.this.arn
}
output "id" {
  value = aws_secretsmanager_secret.this.id
}
output "resultant_policy" {
  value = data.aws_iam_policy_document.iam_policy.json
}
output "secret_value_string" {
  value = var.secret_type == "string" ? aws_secretsmanager_secret_version.string[*].secret_string : null
}
output "secret_value_string_arn" {
  value = var.secret_type == "string" ? aws_secretsmanager_secret_version.string[*].arn : null
}
output "secret_value_string_id" {
  value = var.secret_type == "string" ? aws_secretsmanager_secret_version.string[*].id : null
}
output "secret_value_file" {
  value = var.secret_type == "file" ? aws_secretsmanager_secret_version.file[*].secret_string : null
}
output "secret_value_file_arn" {
  value = var.secret_type == "file" ? aws_secretsmanager_secret_version.file[*].arn : null
}
output "secret_value_file_id" {
  value = var.secret_type == "file" ? aws_secretsmanager_secret_version.file[*].id : null
}
output "secret_value_json" {
  value = var.secret_type == "json" ? aws_secretsmanager_secret_version.json[*].secret_string : null
}
output "secret_value_json_arn" {
  value = var.secret_type == "json" ? aws_secretsmanager_secret_version.json[*].arn : null
}
output "secret_value_json_id" {
  value = var.secret_type == "json" ? aws_secretsmanager_secret_version.json[*].id : null
}
