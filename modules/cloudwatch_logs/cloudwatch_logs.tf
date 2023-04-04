resource "aws_cloudwatch_log_group" "aws_cloudwatch_log_group" {
  name              = var.m_name
  retention_in_days = var.m_retention_in_days
}

