# =============================================================================
# A Switch Profiles is assigned to each VSAN Policy
# Policy bucket limitations prevent the reverse of assignment.
# -----------------------------------------------------------------------------


resource "intersight_fabric_fc_network_policy" "fabric_fc_network_policy_a" {
  name            = "${var.policy_prefix}-vsan-a"
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
  name            = "${var.policy_prefix}-vsan-b"
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
  for_each = var.fabric_a_vsan_sets
  name                  = "${var.policy_prefix}-a-vsan-${each.value["vsan_number"]}"
  default_zoning        = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope            = "Uplink"
  vsan_id               = each.value["vsan_number"]
  fcoe_vlan             = each.value["fcoe_number"]
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_a.id
  }
  depends_on = [
    intersight_fabric_fc_network_policy.fabric_fc_network_policy_a
  ]
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
  for_each = var.fabric_b_vsan_sets
  name                  = "${var.policy_prefix}-b-vsan-${each.value["vsan_number"]}"
  default_zoning        = "Disabled"
  #fc_zone_sharing_mode = "Active"
  #fc_zone_sharing_mode = ""
  vsan_scope            = "Uplink"
  vsan_id               = each.value["vsan_number"]
  fcoe_vlan             = each.value["fcoe_number"]
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.fabric_fc_network_policy_b.id
  }
  depends_on = [
    intersight_fabric_fc_network_policy.fabric_fc_network_policy_b
  ]
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
