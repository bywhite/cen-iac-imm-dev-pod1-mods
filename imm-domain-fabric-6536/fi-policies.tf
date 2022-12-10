# This file creates the following policies:
#    - fabric switch control
#    - NTP
#    - network connectivity (DNS)
#    - System QoS
#    - Multicast
#    - SNMP


resource "intersight_fabric_switch_control_policy" "fabric_switch_control_policy1" {
  name        = "${var.policy_prefix}-Switch-Control-Policy"
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
# -----------------------------------------------------------------------------
resource "intersight_ntp_policy" "ntp1" {
  description = var.description
  enabled     = true
  name        = "${var.policy_prefix}-NTP-Policy"
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
# Network Connectivity (DNS)
# -----------------------------------------------------------------------------

# IPv6 is enabled because this is the only way that the provider allows the
# IPv6 DNS servers (primary and alternate) to be set to something. If it is not
# set to something other than null in this resource, then terraform "apply"
# will detect that there are changes to apply every time ("::" -> null).

resource "intersight_networkconfig_policy" "connectivity1" {
  alternate_ipv4dns_server = var.dns_alternate
  preferred_ipv4dns_server = var.dns_preferred
  description              = var.description
  enable_dynamic_dns       = false
  enable_ipv4dns_from_dhcp = false
  enable_ipv6              = false
  enable_ipv6dns_from_dhcp = false
  name                     = "${var.policy_prefix}-DNS-Connectivity-Policy"
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
# -----------------------------------------------------------------------------

# This will create the default System QoS policy with some generic settings
# FlexPod: https://www.cisco.com/c/en/us/td/docs/unified_computing/ucs/UCS_CVDs/flexpod_datacenter_vmware_netappaffa.html
# Needs customization for vNics to change from best effort with MTU 1500 to MTU 9216 and higher priority
resource "intersight_fabric_system_qos_policy" "qos1" {
  name        = "${var.policy_prefix}-System-QOS-Policy"
  description = var.description
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 14
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
    bandwidth_percent  = 20
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
    bandwidth_percent  = 23
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
    bandwidth_percent  = 17
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
    bandwidth_percent  = 26
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
    bandwidth_percent  = 0
    weight             = 10
    cos                = 5
    mtu                = 9216
    multicast_optimize = false
    name               = "Platinum"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  # assign this policy to the switch profiles being created
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
# Multicast
# -----------------------------------------------------------------------------

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy" {
  name               = "${var.policy_prefix}-Multicast-Policy"
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
# SNMP Policy
# -----------------------------------------------------------------------------

resource "intersight_snmp_policy" "snmp1" {
  name        = "${var.policy_prefix}-SNMP-Policy"
  description              = var.description
  enabled                 = true
  snmp_port               = 161
  access_community_string = "anythingbutpublic"
  community_access        = "Disabled"
  trap_community          = "TrapCommunity"
  sys_contact             = "The SysAdmin"
  sys_location            = "The Data Center"
  engine_id               = "vvb"
  snmp_users {
    name         = "snmpuser"
    privacy_type = "AES"
    auth_password    = var.snmp_password
    privacy_password = var.snmp_password
    security_level = "AuthPriv"
    auth_type      = "SHA"
    object_type    = "snmp.User"
  }
  snmp_traps {
    destination = var.snmp_ip
    enabled     = false
    port        = 660
    type        = "Trap"
    user        = "snmpuser"
    nr_version  = "V3"
    object_type = "snmp.Trap"
  }
  dynamic "profiles" {
    for_each = local.chassis_profile_moids
    content {
      moid        = profiles.value
      object_type = "chassis.Profile"
    }
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
    object_type = "organization.Organization"
    moid        = var.organization
  }
    depends_on = [
    intersight_chassis_profile.chassis_9508_profile
  ]
}

# =============================================================================
# Syslog
# -----------------------------------------------------------------------------

resource "intersight_syslog_policy" "syslog_policy" {
  name               = "${var.policy_prefix}-Syslog-FI-Policy"
  description        = var.description
  local_clients {
    min_severity = "warning"
    object_type = "syslog.LocalFileLoggingClient"
  }
  remote_clients {
    enabled      = true
    hostname     = "10.22.22.22"
    port         = 514
    protocol     = "udp"
    min_severity = "warning"
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
