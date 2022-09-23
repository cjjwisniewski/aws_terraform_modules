Example usage:
```
module "mytestrole" {
    source = "$module_source"

    environment = "test"
    app_name = "mytestapp"

    iam_policies = [
        {
            "Statement": {
                "Effect": "Allow",
                "Action": [
                    "secretsmanager:GetSecretValue",
                    "secretsmanager:DescribeSecret",
                    "secretsmanager:ListSecrets"
                ],
                "Resources": [
                    module.secret.secret_value_json_arn
                ]
            }
        }
    ]

    assume_role_policy = [
        {
            "Statement": {
                "Effect": "Allow",
                "Action": [
                    "sts:AssumeRoleWithWebIdentity"
                ]
                "Principal": {
                    "Federated": "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/abcde12345"
                }
                "Condition": {
                    0: {
                        test = "StringEquals"
                        variable = "oidc.eks.us-east-2.amazonaws.com/id/abcde12345:aud"
                        values = ["sts.amazonaws.com"]
                    }
                    1: {
                        test = "StringEquals"
                        variable = "oidc.eks.us-east-2.amazonaws.com/id/abcde12345:sub"
                        values = ["system:serviceaccount:mytestnamespace:mytestapp"]
                    }
                }
            }
        }
    ]

    tags = module.tags.tags
}
```