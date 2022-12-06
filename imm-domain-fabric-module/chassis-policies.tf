# Policies consumed by Chassis Profiles


resource "intersight_access_policy" "chassis_9508_access1" {
  name        = "${var.policy_prefix}-chassis-9508-imc-access"
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
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

# Need Power Policy for 9508

# Need Thermal Policy for 9508

# Need to Consume an SNMP policy

