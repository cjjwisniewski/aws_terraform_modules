output "arn" {
  value = aws_iam_role.this.arn
}
output "id" {
  value = aws_iam_role.this.id
}
output "name" {
  value = aws_iam_role.this.name
}
output "resultant_policy" {
  value = data.aws_iam_policy_document.iam_policy.json
}
output "resultant_assume_role_policy" {
  value = data.aws_iam_policy_document.assume_role_policy.json
}