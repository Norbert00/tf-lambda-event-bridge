
variable "lambda_function_name" {
  type    = string
  default = "tf-lambda-add-tag"
}


variable "principals" {
  type = map(object({
    type        = string
    identifiers = list(string)
  }))
}


variable "iam_policy" {
  type = object({
    name        = string
    path        = string
    description = string
  })
  validation {
    condition     = startswith(var.iam_policy.path, "/")
    error_message = "Path must start from /."
  }
}


variable "s3_bucket_with_tags" {
  type    = string
  default = "tag-holds-bucket/tags.csv"
}


variable "region_of_instances" {
  type    = string
  default = "109028672636"
}


variable "aws_iam_role_name" {
  type = string
}
