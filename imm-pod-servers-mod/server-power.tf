# =============================================================================
# Power Related Server Policies
#  - Power Policy
#  - 
#  - 
# -----------------------------------------------------------------------------

# =============================================================================
# Server Power Policy
# -----------------------------------------------------------------------------
resource "intersight_power_policy" "server_power_x_vmw" {
  name        = "${var.policy_prefix}-server-power-vmw"
  description              = var.description
  power_priority = "Medium"
  power_profiling = "Enabled"
  power_restore_state = "LastState"
  power_save_mode = "Enabled"
  
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
#   dynamic "profiles" {
#     for_each = local.server_profile_moids
#     content {
#       moid        = profiles.value
#       object_type = "server.Profile"
#     }
#   }
  profiles {
    moid    = intersight_server_profile_template.server_template_1.moid
    object_type = "server.ProfileTemplate"
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    # server profiles created
  ]
}