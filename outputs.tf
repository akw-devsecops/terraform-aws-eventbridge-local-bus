# Event Bridge Local Bus
output "eventbridge_local_bus_name" {
  description = "Local EventBridge Bus name"
  value       = var.local_bus_name
}

output "eventbridge_local_bus_arn" {
  description = "Local Event Bridge Bus ARN"
  value       = aws_cloudwatch_event_bus.this.arn
}

output "eventbridge_rule_ids" {
  description = "Event Bridge Rule IDs"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.id }
}

output "eventbridge_rule_arns" {
  description = "Event Bridge Rule ARNs"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.arn }
}
