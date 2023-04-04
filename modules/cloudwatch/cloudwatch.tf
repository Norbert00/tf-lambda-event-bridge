locals {
  event_pattern = file("${var.m_event_bridge_pattern}")
}

resource "aws_cloudwatch_event_rule" "tf-event-bridge" {
  name          = var.m_cloudwatch_event_bridge.name
  description   = var.m_cloudwatch_event_bridge.description
  event_pattern = local.event_pattern
}



resource "aws_cloudwatch_event_target" "event_target" {
  rule = aws_cloudwatch_event_rule.tf-event-bridge.name
  arn  = var.m_event_target
}
