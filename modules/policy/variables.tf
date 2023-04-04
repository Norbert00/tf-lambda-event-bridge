variable "lambda_policys" {
  type = object({
    name        = string
    path        = string
    description = string
  })
}

variable "s3_bucket_with_tags" {
  type    = string
  default = "tag-holds-bucket/tags.csv"
}

variable "region_of_instances" {
  type    = string
  default = "109028672636"
}
