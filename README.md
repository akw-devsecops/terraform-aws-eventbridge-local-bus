<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_bus.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus) | resource |
| [aws_cloudwatch_event_bus_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus_policy) | resource |
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_subscriptions"></a> [domain\_subscriptions](#input\_domain\_subscriptions) | Event subscriptions | <pre>map(object({<br>    event_hub_role_arn = string<br>    event_subscriptions = map(object({<br>      event_type           = string<br>      target_arn           = string<br>      sqs_message_group_id = optional(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_local_bus_name"></a> [local\_bus\_name](#input\_local\_bus\_name) | Name of the local event bus | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventbridge_local_bus_arn"></a> [eventbridge\_local\_bus\_arn](#output\_eventbridge\_local\_bus\_arn) | Local Event Bridge Bus ARN |
| <a name="output_eventbridge_local_bus_name"></a> [eventbridge\_local\_bus\_name](#output\_eventbridge\_local\_bus\_name) | Local EventBridge Bus name |
| <a name="output_eventbridge_rule_arns"></a> [eventbridge\_rule\_arns](#output\_eventbridge\_rule\_arns) | Event Bridge Rule ARNs |
| <a name="output_eventbridge_rule_ids"></a> [eventbridge\_rule\_ids](#output\_eventbridge\_rule\_ids) | Event Bridge Rule IDs |
<!-- END_TF_DOCS -->