#  Chassis Profile Creation

resource "intersight_chassis_profile" "chassis_9508_profile" {
  for_each       = local.chassis_index_set
  name            = "${var.policy_prefix}-chassis-${each.value}"
  description     = "9508 chassis profile"
  type            = "instance"
  target_platform = "FIAttached"
  #action          = "No-op"     # removing it did not change state updates to "Deploy"
  #action         = "Validate"
  #iom_profiles    = {  }
  config_context {
    object_type    = "policy.ConfigContext"
    control_action = "deploy"
    error_state    = "Validation-error"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
