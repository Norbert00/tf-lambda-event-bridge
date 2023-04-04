data "aws_iam_policy_document" "lambda_policys" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:::*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
    ]
    resources = ["arn:aws:ec2:*:${data.aws_caller_identity.account_id.id}:instance/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
    ]
    resources = ["arn:aws:s3:::${var.s3_bucket_with_tags}"]
  }
}

data "aws_caller_identity" "account_id" {}


resource "aws_iam_policy" "lambda_policys_tag_ec2_read_s3_logs" {
  name        = var.lambda_policys.name
  path        = var.lambda_policys.path
  description = var.lambda_policys.description
  policy      = data.aws_iam_policy_document.lambda_policys.json
}

