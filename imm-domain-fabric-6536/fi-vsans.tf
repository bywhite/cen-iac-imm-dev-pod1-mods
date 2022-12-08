# =============================================================================
# VSAN Policy Assigned to Switch Profiles
# -----------------------------------------------------------------------------


resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy1" {
  name            = "${var.policy_prefix}-vsan-a-policy-1"
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

resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy2" {
  name            = "${var.policy_prefix}-vsan-b-policy-1"
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


resource "intersight_fabric_vsan" "fabric_vsan1" {
  name                 = "${var.policy_prefix}-vsan-b-policy-1"
  default_zoning       = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope = "Common"
  fcoe_vlan            = 1100
  vsan_id              = 100
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy1.id
  }
}

resource "intersight_fabric_vsan" "fabric_vsan2" {
  name                 = "${var.policy_prefix}-vsan-b-policy-1"
  default_zoning       = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope = "Common"
  fcoe_vlan            = 1200
  vsan_id              = 200
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy2.id
  }
}
