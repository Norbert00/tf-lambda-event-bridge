s3_bucket_with_tags = "tag-holds-bucket/tags.csv"
region_of_instances = "109028672636"

# aws_cloudwatch_log_group = {
#   name              = "/aws/lambda/tf-lambda-add-tag",
#   retention_in_days = 14
# }

# lambda_policys_tag_ec2_read_s3_logs = {
#   name        = "lambda_policys_tag_ec2_read_s3_logs"
#   path        = "/"
#   description = "Policy witch access to ec2_add_tags only create logs and read s3 bucket with tags"
# }

iam_policy = {
  name        = "lambda_policys_tag_ec2_read_s3_logs"
  path        = "/"
  description = "Policy witch access to ec2_add_tags only create logs and read s3 bucket with tags"
}

aws_iam_role_name = "tf-iam_for_lambda"


principals = {
  "lambda" = {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
}
