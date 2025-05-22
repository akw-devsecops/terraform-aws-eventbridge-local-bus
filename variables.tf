variable "local_bus_name" {
  description = "Name of the local event bus"
  type        = string
}

variable "domain_subscriptions" {
  description = "Event subscriptions"
  type = map(object({
    event_hub_role_arn = string
    event_subscriptions = map(object({
      consumer_service     = string
      event_type           = string
      target_arn           = string
      extra_filter         = optional(any)
      sqs_message_group_id = optional(string)
    }))
  }))
}
