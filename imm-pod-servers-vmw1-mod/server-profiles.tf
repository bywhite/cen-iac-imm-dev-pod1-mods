# =============================================================================
# Server Profiles from locally defined server template
# -----------------------------------------------------------------------------
# Reference: https://registry.terraform.io/providers/CiscoDevNet/Intersight/latest/docs/resources/bios_policy


resource "intersight_server_profile" "server_list" {
  count = var.server_count
  name        = "${var.server_policy_prefix}-server-${count.index + 1}"
  description              = var.description
  action = "No-op"
  # server_assignment_mode = "None"  #options: "POOL" "Static"
  target_platform = "FIAttached"
  type = "instance"
  uuid_address_type = "POOL"

  src_template {
      moid = intersight_server_profile_template.server_template_1.moid
      object_type = "server.ProfileTemplate"
    }

  uuid_pool {
      moid        = var.server_uuid_pool_moid
      object_type = "uuidpool.Pool"
    }

  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }

  # dynamic "associated_server_pool" {
  #   for_each = var.associated_server_pool
  #   content {
  #     moid        = assigned_server.value.moid
  #     object_type = "resourcepool.Pool"
  #   }
  # }
  # dynamic "assigned_server" {
  #   for_each = var.assigned_server
  #   content {
  #     moid        = assigned_server.value.moid
  #     object_type = assigned_server.value.object_type
  #   }
  # }


  depends_on = [
    intersight_server_profile_template.server_template_1
  ]
}

