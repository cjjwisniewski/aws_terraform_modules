#Define default IAM policy
data "aws_iam_policy_document" "default_iam_policy" {
  statement {
    actions   = ["iam:List*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

#Define IAM policy
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

#Define default assume role policy
data "aws_iam_policy_document" "default_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#Define assume role policy
data "aws_iam_policy_document" "assume_role_policy" {
  override_policy_documents = [
    data.aws_iam_policy_document.default_assume_role_policy.json
  ]

  dynamic "statement" {
    for_each = var.assume_role_policy
    content {
      effect  = statement.value.Statement.Effect
      actions = statement.value.Statement.Action
      dynamic "principals" {
        for_each = statement.value.Statement.Principal
        content {
          type        = principals.key
          identifiers = [principals.value]
        }
      }
      dynamic "condition" {
        for_each = statement.value.Statement.Condition
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

#Create IAM role and attach inline policy
resource "aws_iam_role" "this" {
  name               = "role-${var.aws_region}-${var.environment}-${var.app_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  inline_policy {
    name   = "rolepolicy-${var.aws_region}-${var.environment}-${var.app_name}"
    policy = data.aws_iam_policy_document.iam_policy.json
  }

  tags = var.tags
}