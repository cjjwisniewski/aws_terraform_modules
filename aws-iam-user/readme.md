Example usage:
```
module "mytestuser" {
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

    tags = module.tags.tags
}
```