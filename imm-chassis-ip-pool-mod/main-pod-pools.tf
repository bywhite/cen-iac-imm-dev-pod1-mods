# This module creates the following pod pools:
#  - IP Pool for Chassis IMC
# -----------------------------------------------------------------------------


# =============================================================================
# IP Pool for Chassis IMC
# -----------------------------------------------------------------------------
# Create a sequential IP pool for IMC access.

resource "intersight_ippool_pool" "ippool_pool_chassis" {
  # moid read by: = intersight_ippool_pool.ippool_pool.moid
  name = "${var.policy_prefix}-pool-ip-chassis-1"
  description = var.description
  assignment_order = "sequential"

  ip_v4_blocks {
    
    from  = var.chassis_ip_start
    #from = "10.10.2.11"

    size  = var.chassis_ip_size
    #size = "150"
  }

  ip_v4_config {
    object_type = "ippool.IpV4Config"
    
    gateway        = var.chassis_ip_gateway
    #gateway       = "10.10.2.1"
    
    netmask        = var.chassis_ip_netmask
    #netmask       = "255.255.255.0"
    
    primary_dns    = var.chassis_ip_primary_dns
    #primary_dns   = "8.8.8.8"
    
    }

  organization {
      object_type = "organization.Organization"
      moid = var.organization
      }
}
