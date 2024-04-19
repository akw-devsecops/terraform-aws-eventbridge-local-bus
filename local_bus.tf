# create one local bus
resource "aws_cloudwatch_event_bus" "this" {
  name = var.local_bus_name
}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = "DomainBusPermissions"
    effect    = "Allow"
    actions   = ["events:PutEvents"]
    resources = [aws_cloudwatch_event_bus.this.arn]

    principals {
      type        = "AWS"
      identifiers = [for v in var.domain_subscriptions : v.event_hub_role_arn]
    }
  }
}

# create policy for local bus
resource "aws_cloudwatch_event_bus_policy" "this" {
  event_bus_name = aws_cloudwatch_event_bus.this.name
  policy         = data.aws_iam_policy_document.this.json
}

# create rules for local bus
resource "aws_cloudwatch_event_rule" "this" {
  for_each = { for sub in local.domain_subscriptions : "${sub.name}" => sub }

  event_bus_name = aws_cloudwatch_event_bus.this.arn

  name          = each.value.name
  description   = each.value.description
  event_pattern = each.value.event_pattern
}

# create targets for local bus
resource "aws_cloudwatch_event_target" "this" {
  for_each = { for sub in local.domain_subscriptions : "${sub.name}" => sub }

  event_bus_name = aws_cloudwatch_event_bus.this.arn

  rule = each.value.name
  arn  = each.value.target_arn

  dynamic "sqs_target" {
    for_each = each.value.sqs_message_group_id == null ? [0] : []

    content {
      message_group_id = each.value.sqs_message_group_id
    }
  }

  depends_on = [
    aws_cloudwatch_event_rule.this[0]
  ]
}
