# =============================================================================
# VSAN Policy Assigned to Switch Profiles
# -----------------------------------------------------------------------------


resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy_a" {
  name            = "${var.policy_prefix}-vsan-a-1"
  description     = "${var.description} FC network policy"
  enable_trunking = true
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
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

resource "intersight_fabric_vsan" "fabric_vsan_a" {
  name                 = "${var.policy_prefix}-vsan-a-1"
  default_zoning       = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope = "Uplink"
  
  # will use each of fc_6536_vsans_a
  fcoe_vlan            = 1100
  vsan_id              = 100
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_a.id
  }
}


resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy_b" {
  name            = "${var.policy_prefix}-vsan-b-1"
  description     = "${var.description} FC network policy"
  enable_trunking = true
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

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

resource "intersight_fabric_vsan" "fabric_vsan_b" {
  name                 = "${var.policy_prefix}-vsan-b-1"
  default_zoning       = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope = "Uplink"
  # will use each of fc_6536_vsans_b

  fcoe_vlan            = 1200
  vsan_id              = 200
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_b.id
  }
}
