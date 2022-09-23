Examples:

Text secret:
```
module "secret" {
    source = "$module_source"
    environment = "test
    app_name = "mytestapp"
    secret_name = "example-text-secret"
    secret_type = "string"
    secret_value = "hunter2"
    tags = module.tags.tags
}
```

File secret:
```
module "secret" {
    source = "$module_source"
    environment = "test
    app_name = "mytestapp"
    secret_name = "example-file-secret"
    secret_type = "file"
    secret_value = "C:\users\jdoe\my-super-secret-password.txt"
    tags = module.tags.tags
}
```

JSON secret with IAM policy:
```
module "secret" {
    source = "$module_source"
    environment = "test"
    app_name = "mytestapp"
    secret_name = "example-json-secret"
    secret_type = "json"
    secret_value = {
        "key1": "value1"
        "key2": "value2"
    }
    iam_policies = [
        {
            "Statement": {
                "Effect": "Allow",
                "Action": [
                    "secretsmanager:GetSecretValue",
                    "secretsmanager:DescribeSecret"
                ],
                "Resources": [
                    "*"
                ]
                "Principal": {
                    "AWS": ["123456789123","arn:aws:iam::example-arn"]
                }
            }
        }
    ]
    tags = module.tags.tags
}
```