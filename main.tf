terraform {
  backend "s3" {
    bucket = "tf-remote-state-v01"
    key    = "remote-state/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "aws_caller_identity" "account_id" {}


module "iam_policy" {
  source = "./modules/iam_policy"

  m_name        = "lambda_policys_tag_ec2_read_s3_logs"
  m_path        = "/"
  m_description = "lambda_policys_tag_ec2_read_s3_logs"
  m_statement_map = {
    "logs" = {
      effect = "Allow"
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]

      resources = ["arn:aws:logs:eu-central-1:109028672636:log-group:/aws/lambda/tf-lambda_add_tag_ec2:*", "arn:aws:logs:eu-central-1:109028672636:log-group:/aws/lambda/tf-lambda_add_tag_ec2"]
    }
    "ec2" = {
      effect = "Allow"
      actions = [
        "ec2:CreateTags",
      ]
      resources = ["arn:aws:ec2:*:109028672636:instance/*"]
    }
    "s3" = {
      effect    = "Allow"
      actions   = ["s3:GetObject", ]
      resources = ["arn:aws:s3:::tag-holds-bucket/tags.csv"]
    }
  }
}


module "role" {
  source = "./modules/role"

  m_name       = var.aws_iam_role_name
  m_principals = var.principals
  m_policy_arn = module.iam_policy.iam_arn
}

module "cloudwatch_logs" {
  source = "./modules/cloudwatch_logs"

  m_name              = "/aws/lambda/tf-lambda_add_tag_ec2"
  m_retention_in_days = 14
}


module "cloudwatch_eventbridge" {
  source = "./modules/cloudwatch"

  m_event_bridge_pattern = "./user_data/event_bridge_pattern.json"
  m_cloudwatch_event_bridge = {
    name        = "tf-event-bridge"
    description = "Add tag to ec2"
  }
  m_event_target = module.lambda.lambda_arn
}

module "lambda" {
  source = "./modules/lambda"

  m_statement_id = "AllowExecutionFromCloudWatch"
  m_action       = "lambda:InvokeFunction"
  m_principal    = "events.amazonaws.com"

  m_lambda_function_name = "tf-lambda_add_tag_ec2"
  m_source_arn           = module.cloudwatch_eventbridge.tf-event-bridge_arn_output
  m_role_arn             = module.role.arn
  m_handler              = "lambda_add_tag_ec2.lambda_handler"
  m_runtime              = "python3.8"
  m_source_file          = "./lambda_add_tag_ec2.py"

  m_env_variables = {
    env_bucket_name = "tag-holds-bucket"
    env_file_name   = "tags.csv"
  }
}



