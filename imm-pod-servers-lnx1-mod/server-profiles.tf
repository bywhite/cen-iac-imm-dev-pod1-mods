# =============================================================================
# Server Profiles from locally defined server template
# -----------------------------------------------------------------------------
# Reference: https://registry.terraform.io/providers/CiscoDevNet/Intersight/latest/docs/resources/bios_policy


resource "intersight_server_profile" "server_profile_list" {
  # Will add Count to create multiple instances and use index to change server names
  count = var.server_count

  name                   = "${var.server_policy_prefix}-server-${count.index + 1}"
  # description          = var.description        # Set by template
  # action               = "No-op"                # Set by template
  server_assignment_mode = "None"                 #options: "POOL" "Static" "None"
  # target_platform      = "FIAttached"           # Set by template
  type = "instance"


  src_template {
      moid = intersight_server_profile_template.server_template_1.moid
      object_type = "server.ProfileTemplate"
    }

  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }

#   dynamic "associated_server_pool" {
#     for_each = var.associated_server_pool
#     content {
#       moid        = assigned_server.value.moid
#       object_type = "resourcepool.Pool"
#     }
#   }

#   dynamic "assigned_server" {
#     for_each = var.assigned_server
#     content {
#       moid        = assigned_server.value.moid
#       object_type = assigned_server.value.object_type
#     }
#   }

  # dynamic "tags" {
  #   for_each = var.tags
  #   content {
  #     key   = tags.value.key
  #     value = tags.value.value
  #   }
  # }

  depends_on = [
    intersight_server_profile_template.server_template_1
  ]
}
