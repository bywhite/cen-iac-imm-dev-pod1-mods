# =============================================================================
# Network Related Server Policies
#  - Multicast Policy
#  - Network Control Policy (CDP & LLDP)
#  - Network Group Policy (VLANs)
# -----------------------------------------------------------------------------
# Note: LAN Connectivity Policy & Interfaces are defined per Server Template

# =============================================================================
# Multicast
# -----------------------------------------------------------------------------

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy_1" {
  name               = "${var.policy_prefix}-multicast-01"
  description        = var.description
  querier_ip_address = ""
  querier_state      = "Disabled"
  snooping_state     = "Enabled"
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
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
#  Network Control Policy
# -----------------------------------------------------------------------------

# https://registry.terraform.io/providers/CiscoDevNet/Intersight/latest/docs/resources/fabric_eth_network_control_policy
resource "intersight_fabric_eth_network_control_policy" "fabric_eth_network_control_policy1" {
  name        = "${var.policy_prefix}-eth-network-control-01"
  description = var.description
  cdp_enabled = true
  forge_mac   = "allow"
  lldp_settings {
    object_type      = "fabric.LldpSettings"
    receive_enabled  = true
    transmit_enabled = true
  }
  mac_registration_mode = "allVlans"
  uplink_fail_action    = "linkDown"
  organization {
    moid = var.organization
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
#  Network Group Policy (VLANs)            -tied to each vNIC policy Ex: eth0
#  Used by "intersight_vnic_eth_if" resource to create "eth0", "eth1", etc
# -----------------------------------------------------------------------------
# https://registry.terraform.io/providers/CiscoDevNet/Intersight/latest/docs/resources/fabric_eth_network_group_policy
resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy1" {
  for_each = var.vlan_groups
  # Usage: each.value["native_vlan"]  each.value["vlan_range"]

  name        = "${var.policy_prefix}-${each.value["net_group_name"]}-01"
  description = var.description
  vlan_settings {
    native_vlan   = each.value["native_vlan"]
    allowed_vlans = each.value["vlan_range"]
  }
  organization {
    moid = var.organization
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
