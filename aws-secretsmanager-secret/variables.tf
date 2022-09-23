variable "aws_region" {
  type        = string
  description = "The AWS region in which the resource will be located."
  default     = "us-east-2"
}
variable "environment" {
  type        = string
  description = "The name of the secret to be stored."
}
variable "app_name" {
  type        = string
  description = "The name of the application with which the secret is used."
}
variable "secret_name" {
  type        = string
  description = "The name of the secret to be stored."
}
variable "secret_description" {
  type        = string
  description = "The description of the secret to be stored"
  default     = ""
}
variable "secret_value" {
  type        = any
  description = "The value of the secret. Should be either a string, a map (which will be converted to json), or a path to a file (which will be stored as base64)."
}
variable "tags" {
  type        = map(string)
  description = "A map of tags to be applied to the resource."
}
variable "secret_type" {
  type        = string
  description = "The type of secret to store. Valid values are: string,file,json. Files are encoded to base64."
  validation {
    condition     = contains(["string", "file", "json"], var.secret_type)
    error_message = "Valid values for secret_type are: string,file,json."
  }
}
variable "iam_policies" {
  type        = list(any)
  description = "A list of IAM policies to be applied to the secret object as defined in standard Terraform AWS policy format."
  default     = []
}