# =============================================================================
#  Server Monitoring Related Policies
#  - SNMP Policy
#  - Syslog Policy
# -----------------------------------------------------------------------------

# =============================================================================
# SNMP Policy
# -----------------------------------------------------------------------------

resource "intersight_snmp_policy" "snmp1" {
  name        = "${var.policy_prefix}-snmp-policy"
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
#   profiles {
#     moid        = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
#     object_type = "fabric.SwitchProfile"
#   }

  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
#   depends_on = [
#     
#   ]
}
