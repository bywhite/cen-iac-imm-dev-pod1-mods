# Policies consumed by Chassis Profiles


resource "intersight_access_policy" "chassis_9508_access1" {
  name        = "${var.policy_prefix}-chassis-imc-access-policy-1"
  description = var.description
  inband_vlan = var.chassis_imc_access_vlan
  inband_ip_pool {
    object_type  = "ippool.Pool"
    #moid        = intersight_ippool_pool.ippool_pool1.moid
    moid         = var.chassis_imc_ip_pool_moid
  }
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
    # assign this policy to the chassis profile being created
  profiles {
    moid        = intersight_chassis_profile.chassis_9508_profile1.moid
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


# Optional SNMP policy can be tied to chassis policy bucket
# creating in main policies.tf file


resource "intersight_power_policy" "chassis_9508_power1" {
  name        = "${var.policy_prefix}-chassis-power-policy-1"
  description              = var.description
  power_save_mode = "Enabled"
  dynamic_rebalancing = "Enabled"
  extended_power_capacity = "Enabled"
  allocated_budget = 0

  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }

  # assign this policy to the chassis profile being created
  profiles {
    moid        = intersight_chassis_profile.chassis_9508_profile1.moid
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

resource "intersight_thermal_policy" "chassis_9508_thermal1" {
  name        = "${var.policy_prefix}-chassis-thermal-policy-1"
  description              = var.description
  fan_control_mode = "Balanced"

  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }

  # assign this policy to the chassis profile being created
  profiles {
    moid        = intersight_chassis_profile.chassis_9508_profile1.moid
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
