# This file shows an example how to use and setup the terraform-aws-eventbridge-local-bus module

# The local bus in an account receives events from its domain bus (which is stored in an another account)
# This local bus also need rules and targets to forward the events to a queue (can be any other target, in this case its a sqs queue)


module "local_bus" {
  source = ""

  # specify a name for your local bus
  local_bus_name = ""

  # this is the basic setup of the variable domain_subscriptions
  # in this variable is defined: which target (queue) receive which events of a domain bus based on an event type
  # domain bus -> sends event to this local bus -> local bus forward event to queue for further processing
  domain_subscriptions_example_empty = {
    machine_data = {
      event_hub_role_arn = ""
      event_subscriptions = {
        new_software_release_available = { # this will be the rule name
          consumer_service = ""            # which service is consuming the event
          event_type       = ""
          extra_filter     = "" # add additional event patterns
          target_arn       = "" # this will be the target (queue)
        }
      }
    }
  }


  # complete example:
  domain_subscriptions = {
    software_data = {
      event_hub_role_arn = "arn:aws:iam::123456789012:role/software_data-domain-bus-invoke-local-event-buses"
      event_subscriptions = {
        sap_delivery_posted = {
          consumer_service = "KaercherOrderService"
          event_type       = "Logistic.SAP.SAPDeliveryPosted.V2"
          extra_filter = {
            "detail.data" = {
              Changes = {
                fieldName = ["Resource.Status"]
              }
            }
          }
          /* Example of the event pattern:
          {
            "detail.data": {
              "Changes": {
                "fieldName": ["Resource.Status"]
              }
            },
            "detail.type": ["Logistic.SAP.SAPDeliveryPosted.V2"]
        }
          */
          target_arn = "arn:aws:sqs:eu-west-1:123456789012:eventhub-poc-softwaredata-queue"
        },
        sap_delivery_posted = {
          consumer_service = "ReturnService"
          event_type       = "Logistic.SAP.SAPDeliveryPosted.V2"
          extra_filter     = {}
          target_arn       = "arn:aws:sqs:eu-west-1:123456789012:eventhub-poc-softwaredata-queue"
        }
      }
    }
  }
}
