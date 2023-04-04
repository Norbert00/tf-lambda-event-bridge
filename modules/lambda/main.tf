locals {
  output_path = "./outputs/lambda_add_tag_ec2.zip"
}

resource "aws_lambda_permission" "tf-allow_cloudwatch" {
  statement_id  = var.m_statement_id
  action        = var.m_action
  function_name = var.m_lambda_function_name
  principal     = var.m_principal
  source_arn    = var.m_source_arn
}

resource "aws_lambda_function" "tf-lambda" {
  function_name = var.m_lambda_function_name
  role          = var.m_role_arn
  handler       = var.m_handler
  runtime       = var.m_runtime
  filename      = data.archive_file.init.output_path

  environment {
    variables = var.m_env_variables
  }

  source_code_hash = data.archive_file.init.output_base64sha256

}

data "archive_file" "init" {
  type = "zip"
  output_path = local.output_path
  source_file = var.m_source_file
}



