locals {
  domain_subscriptions = flatten([
    for dk, dv in var.domain_subscriptions : [
      for ek, ev in dv.event_subscriptions : {
        domain      = dk
        name        = ek
        description = "${dk} domain bus subscription"
        event_pattern = (
          ev.extra_filter != null ?
          jsonencode(merge(
            { "detail.type" : [ev.event_type] },
            ev.extra_filter
          )) :
          jsonencode({ "detail.type" : [ev.event_type] })
        )
        target_arn           = ev.target_arn
        sqs_message_group_id = ev.sqs_message_group_id
        consumer_service     = ev.consumer_service
      }
    ]
  ])
}
