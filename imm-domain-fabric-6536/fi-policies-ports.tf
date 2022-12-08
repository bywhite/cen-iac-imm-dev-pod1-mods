# This builds the FI port policy for 6536 and 6432 FIs
#
# The port policy is the parent for port mode and role


# =============================================================================
# 6536 Switch Port Policies
# -----------------------------------------------------------------------------

### 6536 FI-A port_policy ####
resource "intersight_fabric_port_policy" "fi6536_port_policy_a" {
  name         = "${var.policy_prefix}-FI-A-Port-Policy"
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

### 6536 FI-B port_policy ####
resource "intersight_fabric_port_policy" "fi6536_port_policy_b" {
  name         = "${var.policy_prefix}-FI-B-Port-Policy"
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


# set the last two ports to be FC
resource "intersight_fabric_port_mode" "fi6536_port_mode_a-35" {
 #count = (var.fc_port_count_6536 > 0) ? 1 : 0

  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode    = "BreakoutFibreChannel32G"
  port_id_end    = 35
  port_id_start = 35
  #port_id_start  = "${36 - var.fc_port_count_6536 + 1}"
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
resource "intersight_fabric_port_mode" "fi6536_port_mode_a-36" {
 #count = (var.fc_port_count_6536 > 0) ? 1 : 0

  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode    = "BreakoutFibreChannel32G"
  port_id_end    = 36
  port_id_start = 36
  #port_id_start  = "${36 - var.fc_port_count_6536 + 1}"
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




# set the last two ports to be FC
resource "intersight_fabric_port_mode" "fi6536_port_mode_b-35" {
 # count = (var.fc_port_count_6536 > 0) ? 1 : 0

  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode   = "BreakoutFibreChannel32G"
  port_id_end   = 35
  port_id_start = 35
  #port_id_start   = "${36 - var.fc_port_count_6536 + 1}"
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
resource "intersight_fabric_port_mode" "fi6536_port_mode_b-36" {
 # count = (var.fc_port_count_6536 > 0) ? 1 : 0

  #custom_mode   = "BreakoutFibreChannel16G"
  custom_mode   = "BreakoutFibreChannel32G"
  port_id_end   = 36
  port_id_start = 36
  #port_id_start   = "${36 - var.fc_port_count_6536 + 1}"
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
 
resource "intersight_fabric_port_mode" "fi6536_port_mode_a-1" {
 # count = (var.fc_port_count_6536 > 0) ? 1 : 0

  #custom_mode   = "BreakoutEthernet25G"
  custom_mode   = "BreakoutEthernet10G"
  port_id_end   = 1
  port_id_start = 1
  #port_id_start   = "${36 - var.fc_port_count_6536 + 1}"
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
}
 resource "intersight_fabric_port_mode" "fi6536_port_mode_b-1" {
 # count = (var.fc_port_count_6536 > 0) ? 1 : 0

  #custom_mode   = "BreakoutEthernet25G"
  custom_mode   = "BreakoutEthernet10G"
  port_id_end   = 1
  port_id_start = 1
  #port_id_start   = "${36 - var.fc_port_count_6536 + 1}"
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
 



# assign server role to designated ports on FI-A  port_policy
resource "intersight_fabric_server_role" "fi6536_server_role_a" {
  for_each = var.server_ports_6536

  aggregate_port_id = 0
  port_id           = each.value
  slot_id           = 1
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

# assign server role to designated ports on FI-B port_policy
resource "intersight_fabric_server_role" "fi6536_server_role_b" {
  for_each = var.server_ports_6536

  aggregate_port_id = 0
  port_id           = each.value
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
}

# assign ports for Eth uplink port channel on both 6536 FI  port_policy
resource "intersight_fabric_uplink_pc_role" "fi6536_uplink_pc_role_a" {
  pc_id = 33
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
    moid        = intersight_fabric_port_policy.fi6536_port_policy_a.moid
    object_type = "fabric.PortPolicy"
  }

  eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy_a.moid 
  }
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
  eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy_b.moid
  }
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

# Configure FC uplink Port Channel for FI-A
resource "intersight_fabric_fc_uplink_pc_role" "fabric_fc_uplink_pc_role_a" {
# admin_speed   = "16Gbps"
  admin_speed   = "32Gbps"
  fill_pattern  = "Idle"
  #fill_pattern = "Arbff"
  vsan_id      = 100
  pc_id = 35
  port_policy {
    moid = intersight_fabric_port_policy.fi6536_port_policy_a.moid
  }
  # ports {
  #     aggregate_port_id = 36
  #     port_id           = 1
  #     slot_id           = 1
    
  # }
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

# Configure FC uplink Port Channel for FI-A
resource "intersight_fabric_fc_uplink_pc_role" "fabric_fc_uplink_pc_role_b" {
# admin_speed   = "16Gbps"
  admin_speed   = "32Gbps"
  fill_pattern  = "Idle"
  #fill_pattern = "Arbff"
  vsan_id      = 200
  pc_id = 36
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

resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy_a" {
  name        = "${var.policy_prefix}-FI-A-Eth_Network_Group-Policy"
  description = "VLAN Group listing allowed on Uplinks"
  vlan_settings {
    native_vlan   = 1
    allowed_vlans = var.allowed_vlans_6536
    object_type   = "fabric.VlanSettings"
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

resource "intersight_fabric_eth_network_group_policy" "fabric_eth_network_group_policy_b" {
  name        = "${var.policy_prefix}-FI-B-Eth_Network_Group-Policy"
  description = "VLAN Group listing allowed on Uplinks"
  vlan_settings {
    native_vlan   = 1
    allowed_vlans = var.allowed_vlans_6536
    object_type   = "fabric.VlanSettings"
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

resource "intersight_fabric_flow_control_policy" "fabric_flow_control_policy" {
  name        = "${var.policy_prefix}-FI-Flow-Control-Policy"
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

resource "intersight_fabric_link_aggregation_policy" "fabric_link_agg_policy" {
  name        = "${var.policy_prefix}-FI-Link-Agg-Policy"
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

resource "intersight_fabric_link_control_policy" "fabric_link_control_policy" {
  name        = "${var.policy_prefix}-FI-Link-Control-Policy"
  description = "Link Control Settings for Eth Port Channel Uplink Ports"

  udld_settings = [
    admin_state = "Enabled",
    mode        = "normal"
  ]

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
