Example usage:
```
module "ecr" {
  source = "$module_source"
  app_name = "mytestapp"
  tags = module.tags.tags
}
```