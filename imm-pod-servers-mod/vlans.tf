# =============================================================================
# VLAN Related Server Policies
#  - VLAN Policy
#  - 
# -----------------------------------------------------------------------------


# =============================================================================
# VLANs for the above policy
# -----------------------------------------------------------------------------
resource "intersight_fabric_vlan" "fabric_vlan1" {
  # for_each = local.uplink_vlans_6454
  for_each = {
    "vlan-42"   = "42"
    "vlan-43"   = "43"
    "vlan-1000" = "1000"
    "vlan-1001" = "1001"
    }
  auto_allow_on_uplinks = true
  is_native             = false
  name                  = each.key
  vlan_id               = each.value
  multicast_policy {
    moid = intersight_fabric_multicast_policy.fabric_multicast_policy_1.moid
  }
  eth_network_policy {
    moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.id
  }
}

