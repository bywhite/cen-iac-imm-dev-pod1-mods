# This builds the FI port policy for 6536 and 6432 FIs
#
# The port policy is the parent for port mode and role


# =============================================================================
# 6536 Switch Port Policies
# -----------------------------------------------------------------------------

### 6536 FI-A port_policy ####
# Separte port policy for separate VSAN ID's on Uplinks
resource "intersight_fabric_port_policy" "fi6536_port_policy-a" {
  name         = "${var.policy_prefix}-fi6536-port-policy-1"
  description  = var.description
  device_model = "UCS-FI-6536"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  # assign this policy to the FI-A switch profile being created
  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

### 6536 FI-B port_policy ####
# Separte port policy for separate VSAN ID's on Uplinks
resource "intersight_fabric_port_policy" "fi6536_port_policy-b" {
  name         = "${var.policy_prefix}-fi6536-port-policy-1"
  description  = var.description
  device_model = "UCS-FI-6536"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  # assign this policy to the FI-B switch profile being created
  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_b.moid
    object_type = "fabric.SwitchProfile"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


# set the last two ports to be FC
resource "intersight_fabric_port_mode" "fi6536_port_mode1" {
  count = (var.fc_port_count_6536 > 0) ? 1 : 0

  custom_mode   = "FibreChannel"
  port_id_end   = 36
  port_id_start = 35
  #port_id_start   = "${36 - var.fc_port_count_6536 + 1}"
  slot_id       = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy-a.moid
  }
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy-b.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

# assign server role to designated ports on both 6536 FI pair port_policy
resource "intersight_fabric_server_role" "fi6536_server_role1" {
  for_each = var.server_ports_6454

  aggregate_port_id = 0
  port_id           = each.value
  slot_id           = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy-a.moid
  }
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy-b.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

# assign ports for Eth uplink port channel on both 6536 FI pair port_policy
resource "intersight_fabric_uplink_pc_role" "fi6536_uplink_pc_role1" {
  pc_id = 100
  #Port Channel ID is not seen by connected network switch
  dynamic "ports" {
    for_each = var.port_channel_6536
    content {
      port_id           = ports.value
      aggregate_port_id = 0
      slot_id           = 1
    }
  }
  admin_speed = "Auto"
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy-a.moid
  }
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy-b.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


# -----------------------------------------------------------------------------
# END OF   6536 Switch Port Policies
# =============================================================================
