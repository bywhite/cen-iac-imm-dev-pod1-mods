# =============================================================================
#  FI Switch Related  Policies
#  - Fabric Switch Control Policy
#  - NTP Policy
#  - Network Config (DNS) Policy
#  - Fabric System QoS Policy (CoS)
#  - MultiCast Policy
#  - Syslog Policy
# -----------------------------------------------------------------------------

# =============================================================================
# Switch Control Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_switch_control_policy
# -----------------------------------------------------------------------------
resource "intersight_fabric_switch_control_policy" "fabric_switch_control_policy1" {
  name        = "${var.policy_prefix}-switch-control-policy"
  description = var.description
  mac_aging_settings {
    mac_aging_option = "Default"
    mac_aging_time   = 14500
    object_type      = "fabric.MacAgingSettings"
  }
  vlan_port_optimization_enabled = true
  ethernet_switching_mode = "end-host"
  fc_switching_mode = "end-host"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_b.moid
    object_type = "fabric.SwitchProfile"
  }
}


# =============================================================================
# NTP Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ntp_policy
# -----------------------------------------------------------------------------
resource "intersight_ntp_policy" "ntp1" {
  description = var.description
  enabled     = true
  name        = "${var.policy_prefix}-ntp-policy"
  timezone    = var.ntp_timezone
  ntp_servers = var.ntp_servers
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the domain profiles being created instead of policy buckets
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
# Network Config Policy (DNS)
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/networkconfig_policy
# -----------------------------------------------------------------------------
# IPv6 is enabled because this is the only way that the provider allows the
# IPv6 DNS servers (primary and alternate) to be set to something. If it is not
# set to something other than null in this resource, then terraform "apply"
# will detect that there are changes to apply every time ("::" -> null).

resource "intersight_networkconfig_policy" "connectivity1" {
  alternate_ipv4dns_server = var.dns_alternate
  preferred_ipv4dns_server = var.dns_preferred
  description              = var.description
  enable_dynamic_dns       = var.enable_dynamic_dns
  enable_ipv4dns_from_dhcp = var.enable_ipv4dns_from_dhcp
  enable_ipv6              = var.enable_ipv6
  enable_ipv6dns_from_dhcp = var.enable_ipv6dns_from_dhcp
  # preferred_ipv6dns_server = "::"
  # alternate_ipv6dns_server = "::"
  name                     = "${var.policy_prefix}-dns-connectivity-policy"
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the domain profile being created instead of policy buckets
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
# System Qos Policy
# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_system_qos_policy
# -----------------------------------------------------------------------------
# This will create the default System Classes for QoS policies (Tune for your environment)
# FlexPod: https://www.cisco.com/c/en/us/td/docs/unified_computing/ucs/UCS_CVDs/flexpod_datacenter_vmware_netappaffa.html
# Needs customization for vNics to change from best effort with MTU 1500 to MTU 9216 and higher priority
resource "intersight_fabric_system_qos_policy" "qos1" {
  name        = "${var.policy_prefix}-system-qos-policy"
  description = var.description
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 14  # Optional
    weight             = 5
    cos                = 255
    mtu                = 1500
    multicast_optimize = false
    name               = "Best Effort"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 20   # Optional
    weight             = 7     
    cos                = 1
    mtu                = 1500
    multicast_optimize = false
    name               = "Bronze"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"  
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 23    # Optional
    weight             = 8
    cos                = 2
    mtu                = 9216
    multicast_optimize = false
    name               = "Silver"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  # Class of Service 3 is used for FibreChannel (fcoe)
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 14     # Optional
    weight             = 5
    cos                = 3
    mtu                = 2240
    multicast_optimize = false
    name               = "FC"
    packet_drop        = false
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 29     # Optional
    weight             = 9
    cos                = 4
    mtu                = 9216
    multicast_optimize = false
    name               = "Gold"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  classes {
    admin_state        = "Disabled"
    # bandwidth_percent  = 0      # Optional
    weight             = 10
    cos                = 5
    mtu                = 9216
    multicast_optimize = false
    name               = "Platinum"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  # Associate this policy directly with the switch profiles
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
  depends_on = [
    intersight_fabric_switch_profile.fi6536_switch_profile_a, intersight_fabric_switch_profile.fi6536_switch_profile_b
  ]
}

# =============================================================================
# Multicast
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_multicast_policy
# -----------------------------------------------------------------------------

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy" {
  name               = "${var.policy_prefix}-multicast-policy"
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
# Syslog
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/syslog_policy
# -----------------------------------------------------------------------------

resource "intersight_syslog_policy" "syslog_policy" {
  name               = "${var.policy_prefix}-syslog-fi-policy"
  description        = var.description
  local_clients {
    min_severity = var.syslog_local_min_severity
    object_type = "syslog.LocalFileLoggingClient"
  }
  remote_clients {
    enabled      = var.syslog_remote_enabled
    hostname     = var.syslog_remote_hostname
    port         = var.syslog_remote_port
    protocol     = var.syslog_remote_protocol
    min_severity = var.syslog_remote_min_severity
    object_type  = "syslog.RemoteLoggingClient"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6536_switch_profile_b.moid
    object_type = "fabric.SwitchProfile"
  }
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
