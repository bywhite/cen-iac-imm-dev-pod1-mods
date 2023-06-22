# =============================================================================
#  Builds 6536 FI Port Related Policies
#  - FI-A Port Policy (Acts as bucket for all port configs)
#  - FI-B Port Policy (Acts as bucket for all port configs)
#  - FI Fabric Port Modes
#  - Server Port Roles
#  - Eth Port Channel Uplink Roles
#  - FC Port Channel Uplink Roles
#  - Eth Network Group Policy (VLANs) on Uplinks
#  - Flow Control Policy
#  - Link Aggregation Policy
#  - Link Control Policy
# -----------------------------------------------------------------------------

# =============================================================================
# FI-A port_policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_policy
# -----------------------------------------------------------------------------
# Associate port policy containing port configs with switch profile
resource "intersight_fabric_port_policy" "fi6536_port_policy_a" {
  name         = "${var.policy_prefix}-fi-a-ports"
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

# =============================================================================
# FI-B port_policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_policy
# -----------------------------------------------------------------------------
# Associate port policy containing port configs with switch profile
resource "intersight_fabric_port_policy" "fi6536_port_policy_b" {
  name         = "${var.policy_prefix}-fi-b-ports"
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

# =============================================================================
# FI-A Port 35 FC Breakout Port Mode Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_mode
# -----------------------------------------------------------------------------
# Ports 33-36 Universal Ports can be FC breakout on 6536
resource "intersight_fabric_port_mode" "fi6536_port_mode_a-35" {
  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode    = "BreakoutFibreChannel32G"
  port_id_end    = 35
  port_id_start  = 35
  slot_id        = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_port_mode.fi6536_port_mode_a-36
  ]
}

# =============================================================================
# FI-A Port 36 FC Breakout Port Mode Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_mode
# -----------------------------------------------------------------------------
# Ports 33-36 Universal Ports can be FC breakout on 6536
resource "intersight_fabric_port_mode" "fi6536_port_mode_a-36" {
  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode    = "BreakoutFibreChannel32G"
  port_id_end    = 36
  port_id_start  = 36
  slot_id        = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
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
# FI-B Port 35 FC Breakout Port Mode Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_mode
# -----------------------------------------------------------------------------
# Ports 33-36 Universal Ports can be FC breakout on 6536
resource "intersight_fabric_port_mode" "fi6536_port_mode_b-35" {
 #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode   = "BreakoutFibreChannel32G"
  port_id_end   = 35
  port_id_start = 35
  slot_id       = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_b.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_port_mode.fi6536_port_mode_b-36
  ]
}

# =============================================================================
# FI-B Port 36 FC Breakout Port Mode Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_mode
# -----------------------------------------------------------------------------
# Ports 33-36 Universal Ports can be FC breakout on 6536
resource "intersight_fabric_port_mode" "fi6536_port_mode_b-36" {
  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode   = "BreakoutFibreChannel32G"
  port_id_end   = 36
  port_id_start = 36
  slot_id       = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_b.moid
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
# FI-A Eth Port Breakout Mode
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_mode
# -----------------------------------------------------------------------------
# FI 6536 can use any port range as 4x ethernet breakout ports
resource "intersight_fabric_port_mode" "fi6536_port_mode_a-1" {
  #count = (var.eth_breakout_count > 0) ? 1 : 0
  count = var.eth_breakout_count
  custom_mode   = "BreakoutEthernet25G"
  #custom_mode   = "BreakoutEthernet10G"
  port_id_end   = var.eth_breakout_start + count.index
  port_id_start = var.eth_breakout_start + count.index
  slot_id       = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_server_role.fi6536_server_role_a, intersight_fabric_server_role.fi6536_server_role_b
  ]
}

# =============================================================================
# FI-B Eth Port Breakout Mode
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_port_mode
# -----------------------------------------------------------------------------
# FI 6536 can use any port range as 4x ethernet breakout ports
 resource "intersight_fabric_port_mode" "fi6536_port_mode_b-1" {
  count = var.eth_breakout_count
  custom_mode   = "BreakoutEthernet25G"
  #custom_mode   = "BreakoutEthernet10G"
  port_id_end   = var.eth_breakout_start + count.index
  port_id_start = var.eth_breakout_start + count.index
  slot_id       = 1
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_b.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
 depends_on = [
   intersight_fabric_server_role.fi6536_server_role_a, intersight_fabric_server_role.fi6536_server_role_b
 ]
}

# =============================================================================
# FI-A Fabric Server-Port Role for Breakout Ports (if any exist)
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_server_role
# -----------------------------------------------------------------------------
# assign server role to designated ports on FI-A Aggregate ports
resource "intersight_fabric_server_role" "server_role_aggr_a" {
  for_each = var.eth_breakout_count != 0 ? var.eth_aggr_server_ports : {}

  aggregate_port_id     = each.value.aggregate_port_id
  port_id               = each.value.port_id
  slot_id               = 1

  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_port_mode.fi6536_port_mode_a-1
  ]
}

# =============================================================================
# FI-B Fabric Server-Port Role for Breakout Ports (if any exist)
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_server_role
# -----------------------------------------------------------------------------
# assign server role to designated ports on FI-B Aggregate ports
resource "intersight_fabric_server_role" "server_role_aggr_b" {
  for_each = var.eth_breakout_count != 0 ? var.eth_aggr_server_ports : {}

  aggregate_port_id = each.value.aggregate_port_id
  port_id           = each.value.port_id
  slot_id           = 1

  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_b.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_port_mode.fi6536_port_mode_b-1
  ]
}


# =============================================================================
# FI-A Fabric Server-Port Role
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_server_role
# -----------------------------------------------------------------------------
# assign server role to designated ports on FI-A port_policy
resource "intersight_fabric_server_role" "fi6536_server_role_a" {
  for_each = var.server_ports_6536

  aggregate_port_id     = 0
  port_id               = tonumber(each.key)
  slot_id               = 1
  preferred_device_id   = tonumber(each.value)
  preferred_device_type = "Chassis"

  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
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
# FI-B Fabric Server-Port Role
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_server_role
# -----------------------------------------------------------------------------
# assign server role to designated ports on FI-B port_policy
resource "intersight_fabric_server_role" "fi6536_server_role_b" {
  for_each = var.server_ports_6536

  aggregate_port_id     = 0
  port_id               = tonumber(each.key)
  slot_id               = 1
  #preferred_device_id   = tonumber(each.value)
  # example using chassis_ifm_uplink_count used to determine chassis preferred_device_id assuming ports 1-30
  preferred_device_id  = ceil(tonumber(each.key)/var.chassis_ifm_uplink_count)
  preferred_device_type = "Chassis"

  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_b.moid
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
# FI-A Fabric Uplink PC Role
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_uplink_pc_role
# -----------------------------------------------------------------------------
# assign ports for Eth uplink port channel on both 6536 FI port_policy
resource "intersight_fabric_uplink_pc_role" "fi6536_uplink_pc_role_a" {
  pc_id = 33
  dynamic "ports" {
    for_each = var.port_channel_6536
    content {
      port_id           = ports.value
      aggregate_port_id = 0
      slot_id           = 1
      class_id          = "fabric.PortIdentifier"
      object_type       = "fabric.PortIdentifier"
    }
  }
  admin_speed = "Auto"
  port_policy {
    moid        = intersight_fabric_port_policy.fi6536_port_policy_a.moid
    object_type = "fabric.PortPolicy"
  }
  # Network Group Policy only used for Disjoint L2
  # eth_network_group_policy {
  #   moid = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy_a.moid 
  # }
  flow_control_policy {
    moid =  intersight_fabric_flow_control_policy.fabric_flow_control_policy.moid
  }
  link_aggregation_policy {
    moid = intersight_fabric_link_aggregation_policy.fabric_link_agg_policy.moid 
  }
  link_control_policy {
    moid =  intersight_fabric_link_control_policy.fabric_link_control_policy.moid
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
# FI-B Fabric Uplink PC Role
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_uplink_pc_role
# -----------------------------------------------------------------------------
# assign ports for Eth uplink port channel on both 6536 FI port_policy
resource "intersight_fabric_uplink_pc_role" "fi6536_uplink_pc_role_b" {
  pc_id = 34
  #Port Channel ID is not seen by connected network switch
  dynamic "ports" {
    for_each = var.port_channel_6536
    content {
      port_id           = ports.value
      aggregate_port_id = 0
      slot_id           = 1
      class_id          = "fabric.PortIdentifier"
      object_type       = "fabric.PortIdentifier"
    }
  }
  admin_speed = "Auto"
  port_policy {
    moid        = intersight_fabric_port_policy.fi6536_port_policy_b.moid
    object_type = "fabric.PortPolicy"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  # Network Group Policy only used for Disjoint L2
  # eth_network_group_policy {
  #   moid = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy_b.moid
  # }
  flow_control_policy {
    moid =  intersight_fabric_flow_control_policy.fabric_flow_control_policy.moid
  }
 link_aggregation_policy {
    moid = intersight_fabric_link_aggregation_policy.fabric_link_agg_policy.moid 
  }
  link_control_policy {
    moid =  intersight_fabric_link_control_policy.fabric_link_control_policy.moid
  }
}

# =============================================================================
# FI-A FC Fabric Uplink PC Role
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_fc_uplink_pc_role
# -----------------------------------------------------------------------------
# Configure FC uplink Port Channel for FI-A
resource "intersight_fabric_fc_uplink_pc_role" "fabric_fc_uplink_pc_role_a" {
  admin_speed   = var.fc_uplink_pc_a_admin_speed
  fill_pattern  = var.fc_uplink_pc_a_fill_pattern
  vsan_id       = var.fc_uplink_pc_vsan_id_a
  pc_id         = var.fc_uplink_pc_a_pc_id
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
  }
  dynamic "ports" {
    for_each = var.fc_port_channel_6536
    content {
      aggregate_port_id = ports.value.aggport
      port_id           = ports.value.port
      slot_id           = 1
    }
  }
  depends_on = [
    intersight_fabric_port_mode.fi6536_port_mode_a-35, intersight_fabric_port_mode.fi6536_port_mode_a-36
  ]
}

# =============================================================================
# FI-B FC Fabric Uplink PC Role
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_fc_uplink_pc_role
# -----------------------------------------------------------------------------
# Configure FC uplink Port Channel for FI-B
resource "intersight_fabric_fc_uplink_pc_role" "fabric_fc_uplink_pc_role_b" {
  admin_speed   = var.fc_uplink_pc_b_admin_speed
  fill_pattern  = var.fc_uplink_pc_b_fill_pattern
  vsan_id       = var.fc_uplink_pc_vsan_id_b
  pc_id         = var.fc_uplink_pc_b_pc_id
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_b.moid
  }
  dynamic "ports" {
    for_each = var.fc_port_channel_6536
    content {
      aggregate_port_id = ports.value.aggport
      port_id           = ports.value.port
      slot_id           = 1
    }
  }
  depends_on = [
    intersight_fabric_port_mode.fi6536_port_mode_b-35, intersight_fabric_port_mode.fi6536_port_mode_b-36
  ]
}

# # =============================================================================
# # FI-A Eth Network Group Policy (Disjoint L2 Uplinks Only)
# # Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_eth_network_group_policy
# # -----------------------------------------------------------------------------
# # Configure VLAN Group for Uplink - Only used for Disjoint L2
# resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy_a" {
#   name        = "${var.policy_prefix}-fi-a-eth_network_group-1"
#   description = "VLAN Group listing allowed on Uplinks"
#   vlan_settings {
#     native_vlan   = 1
#     allowed_vlans = var.switch_vlans_6536
#     object_type   = "fabric.VlanSettings"
#   }
#   organization {
#     object_type = "organization.Organization"
#     moid        = var.organization
#   }
#   dynamic "tags" {
#     for_each = var.tags
#     content {
#       key   = tags.value.key
#       value = tags.value.value
#     }
#   }
# }

# # =============================================================================
# # FI-B Eth Network Group Policy (Disjoint L2 Uplinks Only)
# # Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_eth_network_group_policy
# # -----------------------------------------------------------------------------
# # Configure VLAN Group for Uplink - Only used for Disjoint L2
# resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy_b" {
#   name        = "${var.policy_prefix}-fi-b-eth_network_group-1"
#   description = "VLAN Group listing allowed on Uplinks"
#   vlan_settings {
#     native_vlan   = 1
#     allowed_vlans = var.switch_vlans_6536
#     object_type   = "fabric.VlanSettings"
#   }
#   organization {
#     object_type = "organization.Organization"
#     moid        = var.organization
#   }
#   dynamic "tags" {
#     for_each = var.tags
#     content {
#       key   = tags.value.key
#       value = tags.value.value
#     }
#   }
# }

# =============================================================================
# Fabric Flow Control Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_flow_control_policy
# -----------------------------------------------------------------------------
# Create flow control policy for Port Channel Uplinks
resource "intersight_fabric_flow_control_policy" "fabric_flow_control_policy" {
  name        = "${var.policy_prefix}-fo-flow-control-1"
  description = "Port Flow control for Eth Port Channel Uplink Ports"
  priority_flow_control_mode = "auto"
  receive_direction = "Disabled"
  send_direction = "Disabled"
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
# Fabric Link Aggregation Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_link_aggregation_policy
# -----------------------------------------------------------------------------
# Create link aggregation policy for Port Channel Uplinks
resource "intersight_fabric_link_aggregation_policy" "fabric_link_agg_policy" {
  name        = "${var.policy_prefix}-fi-link-agg-1"
  description = "Link Aggregation Settings for Eth Port Channel Uplink Ports"
  lacp_rate = "normal"
  suspend_individual = false
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
# Fabric Link Control Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_link_control_policy
# -----------------------------------------------------------------------------
# Create link control policy for Port Channel Uplinks
resource "intersight_fabric_link_control_policy" "fabric_link_control_policy" {
  name        = "${var.policy_prefix}-fi-link-control-1"
  description = "Link Control Settings for Eth Port Channel Uplink Ports"
  udld_settings {
    admin_state = "Enabled"
    mode        = "normal"
  }
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

# -----------------------------------------------------------------------------
# END OF   6536 Switch Port Policies
# =============================================================================
