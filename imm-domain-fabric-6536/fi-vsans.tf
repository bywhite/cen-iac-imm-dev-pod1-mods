# =============================================================================
# A Switch Profiles is assigned to each VSAN Policy
# Policy bucket limitations prevent the reverse of assignment.
# -----------------------------------------------------------------------------


resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy_a" {
  name            = "${var.policy_prefix}-vsan-a-1"
  description     = "${var.description} FC network policy"
  enable_trunking = true
  organization {
    object_type   = "organization.Organization"
    moid          = var.organization
  }
  profiles {
    moid          = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
    object_type   = "fabric.SwitchProfile"
    }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy_b" {
  name            = "${var.policy_prefix}-vsan-b-1"
  description     = "${var.description} FC network policy"
  enable_trunking = true
  organization {
    object_type   = "organization.Organization"
    moid          = var.organization
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


resource "intersight_fabric_vsan" "fabric_vsan_a" {
  for_each = var.fc_6536_vsans_a
  name                  = "${var.policy_prefix}-vsan-a-${each.value["vsan_a"]}"
  default_zoning        = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope            = "Uplink"
  fcoe_vlan             = each.value["fcoe_a_vlan"]
  vsan_id               = each.value["vsan_a"]
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_a.id
  }
}

# resource "intersight_fabric_vsan" "fabric_vsan_a_100" {
#   name                  = "${var.policy_prefix}-vsan-a-100"
#   default_zoning        = "Disabled"
#   #fc_zone_sharing_mode = "Active"
#   #fc_zone_sharing_mode = ""
#   vsan_scope            = "Uplink"
#   fcoe_vlan             = 1100
#   vsan_id               = 100
#   fc_network_policy {
#     moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_a.id
#   }
# }

# resource "intersight_fabric_vsan" "fabric_vsan_a_101" {
#   name                  = "${var.policy_prefix}-vsan-a-101"
#   default_zoning        = "Disabled"
#   #fc_zone_sharing_mode = "Active"
#   #fc_zone_sharing_mode = ""
#   vsan_scope            = "Uplink"
#   fcoe_vlan             = 1101
#   vsan_id               = 101
#   fc_network_policy {
#     moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_a.id
#   }
# }



resource "intersight_fabric_vsan" "fabric_vsan_b" {
  for_each = var.fc_6536_vsans_b
  name                  = "${var.policy_prefix}-vsan-b-${each.value["vsan_b"]}"
  default_zoning        = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope            = "Uplink"
  fcoe_vlan             = each.value["fcoe_b_vlan"]
  vsan_id               = each.value["vsan_b"]
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_b.id
  }
}

# resource "intersight_fabric_vsan" "fabric_vsan_b_200" {
#   name                  = "${var.policy_prefix}-vsan-b-200"
#   default_zoning        = "Disabled"
#   #fc_zone_sharing_mode = "Active"
#   #fc_zone_sharing_mode = ""
#   vsan_scope            = "Uplink"
#   fcoe_vlan             = 1200
#   vsan_id               = 200
#   fc_network_policy {
#     moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_b.id
#   }
# }

# resource "intersight_fabric_vsan" "fabric_vsan_b_201" {
#   name                  = "${var.policy_prefix}-vsan-b-201"
#   default_zoning        = "Disabled"
#   #fc_zone_sharing_mode = "Active"
#   #fc_zone_sharing_mode = ""
#   vsan_scope            = "Uplink"
#   fcoe_vlan             = 1201
#   vsan_id               = 201
#   fc_network_policy {
#     moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_b.id
#   }
# }
