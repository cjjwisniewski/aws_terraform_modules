output "arn" {
  value = aws_iam_user.this.arn
}
output "id" {
  value = aws_iam_user.this.id
}
output "name" {
  value = aws_iam_user.this.name
}
output "resultant_policy" {
  value = data.aws_iam_policy_document.iam_policy.json
}
output "access_key_id" {
  value = aws_iam_access_key.this.id
}
output "access_key_secret" {
  value = aws_iam_access_key.this.secret
}