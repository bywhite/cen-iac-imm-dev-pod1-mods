# =============================================================================
#  Server SNMP Policies
#  
# -----------------------------------------------------------------------------

# =============================================================================
# SNMP Policy
# -----------------------------------------------------------------------------

resource "intersight_snmp_policy" "server_snmp" {
  name        = "${var.policy_prefix}-srv-snmp-01"
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
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}
