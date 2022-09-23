#Define secret
resource "aws_secretsmanager_secret" "this" {
  name        = "${var.environment}/${var.app_name}/${var.secret_name}"
  description = var.secret_description
  tags        = var.tags

  #Replicate secret to us-east-1
  replica {
    region = "us-east-1"
  }
}

#Define secret value for string secrets
resource "aws_secretsmanager_secret_version" "string" {
  count         = var.secret_type == "string" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_value
}

#Define secret value for file secrets
resource "aws_secretsmanager_secret_version" "file" {
  count         = var.secret_type == "file" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = filebase64(var.secret_value)
}

#Define secret value for json secrets
resource "aws_secretsmanager_secret_version" "json" {
  count         = var.secret_type == "json" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_value)
}

#Define default IAM policy
data "aws_iam_policy_document" "default_iam_policy" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:ListSecrets"
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
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
      resources = statement.value.Statement.Resources
      dynamic "principals" {
        for_each = statement.value.Statement.Principal
        content {
          type        = principals.key
          identifiers = principals.value
        }
      }
    }
  }
}

#Create secret policy
resource "aws_secretsmanager_secret_policy" "this" {
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = data.aws_iam_policy_document.iam_policy.json
}