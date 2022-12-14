# =============================================================================
# Network Related Server Policies
#  - Multicast Policy
#  - LAN Connectivity Policy
#  - Network Control Policy (CDP & LLDP)
#  - Network Group Policy (VLANs)
# -----------------------------------------------------------------------------


# =============================================================================
# Multicast
# -----------------------------------------------------------------------------

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy_1" {
  name               = "${var.server_policy_prefix}-multicast-policy-1"
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
# LAN Connectivity
# -----------------------------------------------------------------------------

resource "intersight_vnic_lan_connectivity_policy" "vnic_lan_1" {
  name                = "${var.server_policy_prefix}-lan-connectivity"
  description         = var.description
  iqn_allocation_type = "None"
  placement_mode      = "auto"
  target_platform     = "FIAttached"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
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
  name        = "${var.server_policy_prefix}-eth-network-control"
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
# -----------------------------------------------------------------------------
# https://registry.terraform.io/providers/CiscoDevNet/Intersight/latest/docs/resources/fabric_eth_network_group_policy
resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy1" {
 # Could use for_each to iterate through eth[0] vlans, eth[1] vlans
  name        = "${var.server_policy_prefix}-eth-network-group"
  description = var.description
  vlan_settings {
    # native_vlan   = var.vnic_native_vlan
    native_vlan   = null
    allowed_vlans = "42,1000"
    # allowed_vlans = join(",", values(var.uplink_vlans_6454))
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

