output "arn" {
  value = aws_ecr_repository.this.arn
}
output "registry_id" {
  value = aws_ecr_repository.this.registry_id
}
output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}
output "name" {
  value = aws_ecr_repository.this.name
}
output "resultant_policy" {
  value = data.aws_iam_policy_document.iam_policy.json
}