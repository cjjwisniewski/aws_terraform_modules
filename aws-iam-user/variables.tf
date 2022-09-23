variable "aws_region" {
  type        = string
  description = "The AWS region in which the resource will reside."
  default     = "us-east-2"
}
variable "environment" {
  type        = string
  description = "The environment for which the resource is intended to reside in."
  validation {
    condition     = contains(["dev", "test", "uat", "stage", "prod", "non-prod"], var.environment)
    error_message = "Valid values for environment are: dev,test,uat,stage,prod,non-prod."
  }
}
variable "app_name" {
  type        = string
  description = "The name of the application for which the resource is intended to be used with."
}
variable "tags" {
  type        = map(string)
  description = "A map of tags to be applied to the resource."
}
variable "iam_policies" {
  type        = list(any)
  description = "A list of IAM policies to be applied to the resource as defined in standard Terraform AWS policy format."
  default     = []
}