#Define default IAM policy
data "aws_iam_policy_document" "default_iam_policy" {
  statement {
    effect = "Allow"
    actions = [
      "iam:List*"
    ]
    resources = [
      "*"
    ]
  }
}

#Define policy document for total resultant policy
data "aws_iam_policy_document" "iam_policy" {
  override_policy_documents = [
    data.aws_iam_policy_document.default_iam_policy.json
  ]

  dynamic "statement" {
    for_each = var.iam_policies
    content {
      effect    = statement.value.Statement.Effect
      actions   = statement.value.Statement.Action
      resources = flatten(statement.value.Statement.Resources)
    }
  }
}

#Create IAM role and attach inline policy
resource "aws_iam_user" "this" {
  name = "user-${var.aws_region}-${var.environment}-${var.app_name}"

  tags = var.tags
}

#Create access key for user
resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

#Attach policy to user
resource "aws_iam_user_policy" "this" {
  name   = "userpolicy-${var.aws_region}-${var.environment}-${var.app_name}"
  user   = aws_iam_user.this.name
  policy = data.aws_iam_policy_document.iam_policy.json
}