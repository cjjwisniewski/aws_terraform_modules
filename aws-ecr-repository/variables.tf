variable "aws_region" {
  type        = string
  description = "The AWS region in which the resource will reside."
  default     = "us-east-2"
}
variable "app_name" {
  type        = string
  description = "The name of the application for which the resource is intended to be used with."
}
variable "image_tag_mutability" {
  type        = string
  description = "(Optional) The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE."
  default     = "MUTABLE"
}
variable "scan_on_push" {
  type        = string
  description = "(Required) Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  default     = true
}
variable "iam_policies" {
  type        = list(any)
  description = "A list of IAM policies to be applied to the resource as defined in standard Terraform AWS policy format."
  default     = []
}
variable "tags" {
  type        = map(string)
  description = "A map of tags to be applied to the resource."
}