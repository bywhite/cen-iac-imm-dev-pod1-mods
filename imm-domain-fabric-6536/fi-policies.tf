# This file creates the following policies:
#    - ntp
#    - network connectivity (dns)
#    - System QoS
#    - IMC Access
#    - SNMP

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
  name        = "${var.policy_prefix}-system-qos-policy-1"
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
    auth_password    = var.imc_admin_password
    privacy_password = var.imc_admin_password
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



# =============================================================================
# IMC Access
# -----------------------------------------------------------------------------

resource "intersight_access_policy" "access1" {
  name        = "${var.policy_prefix}-imc-access-policy-1"
  description = var.description
  inband_vlan = var.imc_access_vlan
  inband_ip_pool {
    object_type  = "ippool.Pool"
    #moid        = intersight_ippool_pool.ippool_pool1.moid
    moid         = var.imc_ip_pool_moid
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

# =============================================================================
# Serial Over LAN (optional)
# -----------------------------------------------------------------------------
#
#resource "intersight_sol_policy" "sol1" {
#  name        = "${var.policy_prefix}-sol-off-policy-1"
#  description = var.description
#  enabled     = false
#  baud_rate   = 9600
#  com_port    = "com1"
#  ssh_port    = 1096
#  organization {
#    moid        = var.organization
#    object_type = "organization.Organization"
#  }
#  dynamic "tags" {
#    for_each = var.tags
#    content {
#      key   = tags.value.key
#      value = tags.value.value
#    }
#  }
#}


# =============================================================================
# IPMI over LAN (optional)
# -----------------------------------------------------------------------------
#
#resource "intersight_ipmioverlan_policy" "ipmi2" {
#  description = var.description
#  enabled     = false
#  name        = "${var.policy_prefix}-ipmi-disabled"
#  organization {
#    moid        = var.organization
#    object_type = "organization.Organization"
#  }
#  dynamic "tags" {
#    for_each = var.tags
#    content {
#      key   = tags.value.key
#      value = tags.value.value
#    }
#  }
#}


# # =============================================================================
# # Boot Precision (boot order) Policy
# # -----------------------------------------------------------------------------

# resource "intersight_boot_precision_policy" "boot_precision1" {
#   name                     = "${var.policy_prefix}-vmw-boot-order-policy-1"
#   description              = var.description
#   configured_boot_mode     = "Uefi"
#   enforce_uefi_secure_boot = false
# #  boot_devices {
# #    enabled     = true
# #    name        = "KVM_DVD"
# #    object_type = "boot.VirtualMedia"
# #    additional_properties = jsonencode({
# #      Subtype = "kvm-mapped-dvd"
# #    })
# #  }
# #  boot_devices {
# #    enabled     = true
# #    name        = "IMC_DVD"
# #    object_type = "boot.VirtualMedia"
# #    additional_properties = jsonencode({
# #      Subtype = "cimc-mapped-dvd"
# #    })
# #  }
#   boot_devices {
#     enabled     = true
#     name        = "LocalDisk"
#     object_type = "boot.LocalDisk"
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
# Device Connector Policy (optional)
# -----------------------------------------------------------------------------
#
#resource "intersight_deviceconnector_policy" "dc1" {
#  description     = var.description
#  lockout_enabled = true
#  name            = "${var.policy_prefix}-device-connector"
#  organization {
#    moid        = var.organization
#    object_type = "organization.Organization"
#  }
#  dynamic "tags" {
#    for_each = var.tags
#    content {
#      key   = tags.value.key
#      value = tags.value.value
#    }
#  }
#}


