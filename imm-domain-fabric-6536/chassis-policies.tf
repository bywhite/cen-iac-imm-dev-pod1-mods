# =============================================================================
#  Chassis Related  Policies
#  - Chassis IP Access Policy
#  - Chassis Power Policy
#  - Chassis Thermal Policy
#  - SNMP Policy (Optional)
# -----------------------------------------------------------------------------


# =============================================================================
# Chassis IP Access Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/access_policy
# -----------------------------------------------------------------------------
resource "intersight_access_policy" "chassis_9508_access" {
  name        = "${var.policy_prefix}-chassis-access-1"
  description = var.description
  inband_vlan = var.chassis_imc_access_vlan
  inband_ip_pool {
    object_type  = "ippool.Pool"
    moid         = var.chassis_imc_ip_pool_moid
  }
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "profiles" {
    for_each = local.chassis_profile_moids
    content {
      moid        = profiles.value
      object_type = "chassis.Profile"
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_chassis_profile.chassis_9508_profile
  ]
}

# =============================================================================
# Chassis Power Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/power_policy
# -----------------------------------------------------------------------------
resource "intersight_power_policy" "chassis_9508_power" {
  name                    = "${var.policy_prefix}-chassis-power-1"
  description             = var.description
  power_save_mode         = var.power_save_mode
  dynamic_rebalancing     = var.dynamic_rebalancing
  extended_power_capacity = var.extended_power_capacity
  allocated_budget        = var.allocated_budget
  redundancy_mode         = var.redundancy_mode
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "profiles" {
    for_each = local.chassis_profile_moids
    content {
      moid        = profiles.value
      object_type = "chassis.Profile"
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_chassis_profile.chassis_9508_profile
  ]
}

# =============================================================================
# Chassis Thermal Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/thermal_policy
# -----------------------------------------------------------------------------
resource "intersight_thermal_policy" "chassis_9508_thermal" {
  name        = "${var.policy_prefix}-chassis-thermal-1"
  description              = var.description
  fan_control_mode = var.fan_control_mode
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "profiles" {
    for_each = local.chassis_profile_moids
    content {
      moid        = profiles.value
      object_type = "chassis.Profile"
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_chassis_profile.chassis_9508_profile
  ]
}


# =============================================================================
# SNMP Policy
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/snmp_policy
# -----------------------------------------------------------------------------
# Used by Chassis and FI's
resource "intersight_snmp_policy" "snmp1" {
  name                    = "${var.policy_prefix}-chassis-snmp-policy"
  description             = var.description
  enabled                 = var.snmp_enabled
  snmp_port               = var.snmp_port
  access_community_string = var.access_community_string
  community_access        = var.community_access
  trap_community          = var.trap_community
  sys_contact             = var.sys_contact
  sys_location            = var.sys_location
  engine_id               = var.engine_id
  snmp_users {
    name             = var.snmp_user_name
    privacy_type     = var.privacy_type
    auth_password    = var.snmp_password
    privacy_password = var.snmp_password
    security_level   = var.security_level
    auth_type        = var.auth_type
    object_type      = "snmp.User"
  }
  snmp_traps {
    destination = var.trap_destination
    enabled     = var.trap_enabled
    port        = var.trap_port
    type        = var.trap_type
    user        = var.trap_user
    nr_version  = var.trap_nr_version
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
