# Policies consumed by Chassis Profiles

# Assigns IP address to chassis for managment
resource "intersight_access_policy" "chassis_9508_access" {
  name        = "${var.policy_prefix}-Chassis-IMC-Access-1"
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
    # assign this policy to the chassis profile being created
  # profiles {
  #   moid        = intersight_chassis_profile.chassis_9508_profile[*].moid
  #   object_type = "chassis.Profile"
  # }

  dynamic "profiles" {
    for_each = range(var.chassis_9508_count)
    count {
      moid  = intersight_chassis_profile.chassis_9508_profile[each.value].moid
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
}

# Configure Chassis to Grid power and other power related settings
resource "intersight_power_policy" "chassis_9508_power" {
  name        = "${var.policy_prefix}-Chassis-9508-Power-1"
  description              = var.description
  power_save_mode = "Enabled"
  dynamic_rebalancing = "Enabled"
  extended_power_capacity = "Enabled"
  allocated_budget = 0
  redundancy_mode = "Grid"
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the chassis profile being created
  profiles {
    moid        = intersight_chassis_profile.chassis_9508_profile[1].moid
    object_type = "chassis.Profile"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

# Set Chassis fan characteristics and influence over chassis power consumption
resource "intersight_thermal_policy" "chassis_9508_thermal" {
  name        = "${var.policy_prefix}-Chassis-9508-Thermal-1"
  description              = var.description
  fan_control_mode = "Balanced"
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  # assign this policy to the chassis profile being created
  profiles {
    moid        = intersight_chassis_profile.chassis_9508_profile[1].moid
    object_type = "chassis.Profile"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
