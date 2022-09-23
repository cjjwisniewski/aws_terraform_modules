#Create repository
resource "aws_ecr_repository" "this" {
  name                 = var.app_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}

#Default IAM policy
data "aws_iam_policy_document" "default_iam_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:ListTagsForResource"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values = [
        "o-2je17n209f"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalArn"
      values = [
        "arn:aws:iam::*:role/eks*worker*role"
      ]
    }
  }
}

#IAM Policy
data "aws_iam_policy_document" "iam_policy" {
  override_policy_documents = [
    data.aws_iam_policy_document.default_iam_policy.json
  ]

  dynamic "statement" {
    for_each = var.iam_policies
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

#Set policy on repository
resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.iam_policy.json
}