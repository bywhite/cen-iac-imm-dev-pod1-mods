# =============================================================================
#  VLAN Related  Policies
#  - Eth Network Policy (VLANs for Switches)
#  - Fabric VLAN resources for Eth Network Policy
# -----------------------------------------------------------------------------


# =============================================================================
# Fabric Eth Network (VLAN) Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_eth_network_policy
# -----------------------------------------------------------------------------
resource "intersight_fabric_eth_network_policy" "fabric_eth_network_policy" {
  name        = "${var.policy_prefix}-network-policy"
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

# =============================================================================
# Fabric VLANs
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_vlan
# -----------------------------------------------------------------------------
# Associates VLANs with the above policy   extracted from uplink_vlans_6536
# Example results: {"vlan-5": 5, "vlan22": 22, "vlan23: 23, "vlan24":24}
# Provided vlan_list_set must contain at least 1 "-" hyphen in list
resource "intersight_fabric_vlan" "fabric_vlans" {
  for_each              = local.vlan_list_set
  auto_allow_on_uplinks = true
  is_native             = false
  
  name = length(regexall("^[0-9]{4}$", each.value)) > 0 ? join(
    "_", [var.vlan_prefix, each.value]) : length(
    regexall("^[0-9]{3}$", each.value)) > 0 ? join(
    "_", [var.vlan_prefix, each.value]) : length(
    regexall("^[0-9]{2}$", each.value)) > 0 ? join(
    "_", [var.vlan_prefix, each.value]) : join(
  "_", [var.vlan_prefix, each.value])
  
  vlan_id = each.value
  eth_network_policy {
    moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy.id
  }
  multicast_policy {
    moid = intersight_fabric_multicast_policy.fabric_multicast_policy.moid
  }
}
