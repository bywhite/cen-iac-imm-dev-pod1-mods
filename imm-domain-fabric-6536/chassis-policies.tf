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

profiles = intersight_chassis_profile.chassis_9508_profile[*].moid

  dynamic "profiles" {
    for_each = var.profiles
    content {
      moid        = profiles.value.moid
      object_type = profiles.value.object_type
    }
  }
  
  # dynamic "profiles" {
  #   for_each = toset(intersight_chassis_profile.chassis_9508_profile[*].moid)
  #   content {
  #     moid        = profiles.value.moid
  #     object_type = profiles.value.object_type
  #   }

  # dynamic "profiles" {
  #   for_each = local.chassis_index
  #   # use profiles.value
  #   content {
  #     moid  = intersight_chassis_profile.chassis_9508_profile[each.key].moid
  #     object_type = "chassis.Profile"
  #   }
  # }

  # # This standard block doesn't work 
  # dynamic "profiles" {
  #   for_each = local.chassis_index
  #   content {
  #     moid        = intersight_chassis_profile.chassis_9508_profile[profiles.value].moid
  #     object_type = "chassis.Profile"
  #   }
  # }
# │ Error: error occurred while updating AccessPolicy: 400 Bad Request Response from endpoint: 
# |  {"code":"InvalidRequest","message":"Cannot modify the relationship 'Profiles' 
# |  of the object 'access.Policy:63937bc177696e2d31942994'. 
# |  The ID '63937bc177696e2d31942994' already exists in the object relationship.","messageId":
# | "barcelona_request_duplicate_relationship_id","messageParams":{"1":"access.Policy","2":
# | "Profiles","3":"63937bc177696e2d31942994","4":"63937bc177696e2d31942994"},"traceId":
# | "HqGjhq95L9Bj7eh_O2oDorzx8qqkDZthjr9qtyDbKhgnhwQtGcpEbA=="}
# │ 
# │   with module.intersight_policy_bundle_vmw_1.intersight_access_policy.chassis_9508_access,
# │   on .terraform/modules/intersight_policy_bundle_vmw_1/imm-domain-fabric-6536/chassis-policies.tf line 4, in resource "intersight_access_policy" "chassis_9508_access":
# │    4: resource "intersight_access_policy" "chassis_9508_access" {

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
  # dynamic "profiles" {
  #   for_each = range(var.chassis_9508_count)
  #   content {
  #     moid  = intersight_chassis_profile.chassis_9508_profile[profiles.value].moid
  #     object_type = "chassis.Profile"
  #   }
  # }
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
  # dynamic "profiles" {
  #   for_each = range(var.chassis_9508_count)
  #   content {
  #     moid  = intersight_chassis_profile.chassis_9508_profile[profiles.value].moid
  #     object_type = "chassis.Profile"
  #   }
  # }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
