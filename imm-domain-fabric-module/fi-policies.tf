# This file creates the following policies:
#    - 
#    - NTP
#   -  SNMP
#    - network connectivity (dns)
#    - multicast
#    - System QoS
#    - IMC Access

# =============================================================================
# NTP Policy
# -----------------------------------------------------------------------------

resource "intersight_ntp_policy" "ntp1" {
  description = var.description
  enabled     = true
  name        = "${var.policy_prefix}-ntp-policy-1"
  timezone    = var.ntp_timezone
  ntp_servers = var.ntp_servers
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the domain profiles being created
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_b.moid
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
# will detect that thare changes to apply every time ("::" -> null).

resource "intersight_networkconfig_policy" "connectivity1" {
  alternate_ipv4dns_server = var.dns_alternate
  preferred_ipv4dns_server = var.dns_preferred
  description              = var.description
  enable_dynamic_dns       = false
  enable_ipv4dns_from_dhcp = false
  enable_ipv6              = false
  enable_ipv6dns_from_dhcp = false
  name                     = "${var.policy_prefix}-dns-policy-1"
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the domain profile being created
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_b.moid
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

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy1" {
  name               = "${var.policy_prefix}-multicast-policy-1"
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
# System Qos Policy
# -----------------------------------------------------------------------------

# this will create the default System QoS policy with zero customization
resource "intersight_fabric_system_qos_policy" "qos1" {
  name        = "${var.policy_prefix}-system-qos-policy-1"
  description = var.description

  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the domain profile being created
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_b.moid
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
# SNMP Policy
# -----------------------------------------------------------------------------

# this will create the SNMP policy
resource "intersight_snmp_policy" "snmp1" {
  name        = "${var.policy_prefix}-snmp-policy-1"
  description              = var.description
  enabled                 = true
  snmp_port               = 161
  access_community_string = "anythingbutpublic"
  community_access        = "Disabled"
  trap_community          = "TrapCommunity"
  sys_contact             = "Lance"
  sys_location            = "Lance's house"
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
    destination = "10.10.10.254"
    enabled     = false
    port        = 660
    type        = "Trap"
    user        = "snmpuser"
    nr_version  = "V3"
    object_type = "snmp.Trap"
  }
  profiles {
    moid        = intersight_chassis_profile.chassis_9508_profile1.moid
    object_type = "chassis.Profile"
  }
  
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}



# # =============================================================================
# # IMC Access
# # -----------------------------------------------------------------------------

# resource "intersight_access_policy" "access1" {
#   name        = "${var.policy_prefix}-imc-access-policy-1"
#   description = var.description
#   inband_vlan = var.imc_access_vlan
#   inband_ip_pool {
#     object_type  = "ippool.Pool"
#     #moid        = intersight_ippool_pool.ippool_pool1.moid
#     moid         = var.imc_ip_pool_moid
#   }
#   organization {
#     moid        = var.organization
#     object_type = "organization.Organization"
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
# VLAN Policy for Ethernet Uplink
# -----------------------------------------------------------------------------
resource "intersight_fabric_eth_network_policy" "fabric_eth_network_policy1" {
  name        = "${var.policy_prefix}-vlan-policy-1"
  description = var.description
  organization {
    moid = var.organization
  }
  # assign this policy to the domain profile being created
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_a.moid
    object_type = "fabric.SwitchProfile"
  }
  profiles {
    moid        = intersight_fabric_switch_profile.fi6454_switch_profile_b.moid
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
# VLANs for the above policy
# -----------------------------------------------------------------------------
resource "intersight_fabric_vlan" "fabric_vlan1" {
  for_each = var.uplink_vlans_6454

  auto_allow_on_uplinks = true
  is_native             = false
  name                  = each.key
  vlan_id               = each.value
  multicast_policy {
    moid = intersight_fabric_multicast_policy.fabric_multicast_policy1.moid
  }
  eth_network_policy {
    moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.id
  }
}

