# =============================================================================
# VLAN Policy
# -----------------------------------------------------------------------------
resource "intersight_fabric_eth_network_policy" "fabric_eth_network_policy" {
  name        = "${var.policy_prefix}-vlan-1"
  description = var.description
  organization {
    moid = var.organization
  }
  # assign this policy to the domain profile being created

  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
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


resource "intersight_fabric_vlan" "fabric_vlans" {
  for_each              = local.vlan_list_set
  auto_allow_on_uplinks = true
  is_native             = false
  name = length(regexall("^[0-9]{4}$", each.value)) > 0 ? join(
  #   "-vl", [var.vlan_prefix, each.value]) : length(
  #   regexall("^[0-9]{3}$", each.value)) > 0 ? join(
  #   "-vl0", [var.vlan_prefix, each.value]) : length(
  #   regexall("^[0-9]{2}$", each.value)) > 0 ? join(
  #   "-vl00", [var.vlan_prefix, each.value]) : join(
  # "-vl000", [var.vlan_prefix, each.value])
    "-", [var.vlan_prefix, each.value]) : length(
    regexall("^[0-9]{3}$", each.value)) > 0 ? join(
    "-", [var.vlan_prefix, each.value]) : length(
    regexall("^[0-9]{2}$", each.value)) > 0 ? join(
    "-", [var.vlan_prefix, each.value]) : join(
  "-", [var.vlan_prefix, each.value])
  vlan_id = each.value
  eth_network_policy {
    moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy.id
  }
  multicast_policy {
    moid = intersight_fabric_multicast_policy.fabric_multicast_policy.moid
  }
}
### Replaced by above ###
# # =============================================================================
# # VLANs for the above policy   based on uplink_vlans_6536   
# # Example values: {}"vlan-5": 5, "vlan22": 22, "vlan23: 23, "vlan24":24 }
# # -----------------------------------------------------------------------------
# resource "intersight_fabric_vlan" "fabric_vlans" {
#   for_each = var.uplink_vlans_6536

#   auto_allow_on_uplinks = true
#   is_native             = false
#   name                  = each.key
#   vlan_id               = each.value
#   multicast_policy {
#     moid = intersight_fabric_multicast_policy.fabric_multicast_policy.moid
#   }
#   eth_network_policy {
#     moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy.id
#   }
# }

# =============================================================================
# VLANs for the above policy Based on switch_vlans_6536    Example: "2,3-20,5-50"
# This version allows a much simpler list of vlans to be passed to the module
#  by converting the simple list into a set of "VlAN-Name" : "XXX" pairs
# -----------------------------------------------------------------------------
