output "event_pattern_output" {
  value = local.event_pattern
}


output "tf-event-bridge_arn_output" {
  value = aws_cloudwatch_event_rule.tf-event-bridge.arn
}
