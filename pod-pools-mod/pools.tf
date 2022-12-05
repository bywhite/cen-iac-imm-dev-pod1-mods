# This file creates the following pools:
#    - IP pool for IMC Access
#    - MAC pool for vNICs
#    - WWNN, WWPN-A and WWPN-B FC pools

# Create a sequential IP pool for IMC access.

resource "intersight_ippool_pool" "ippool_pool" {
  # moid read by: = intersight_ippool_pool.ippool_pool.moid
  name = "${var.policy_prefix}-pool-ip-1"
  description = var.description
  assignment_order = "sequential"

  ip_v4_blocks {
    
    from  = var.ip_start
    #from = "1.1.1.11"

    size  = var.ip_size
    #size = "200"
  }

  ip_v4_config {
    object_type = "ippool.IpV4Config"
    
    gateway        = var.ip_gateway
    #gateway       = "10.10.10.1"
    
    netmask        = var.ip_netmask
    #netmask       = "255.255.255.0"
    
    primary_dns    = var.ip_primary_dns
    #primary_dns   = "8.8.8.8"
    
    }

  organization {
      object_type = "organization.Organization"
      moid = var.organization
      }
}


resource "intersight_macpool_pool" "macpool_pool1" {
  name = "${var.policy_prefix}-pool-mac-1"
  description = var.description
  assignment_order = "sequential"
  mac_blocks {
    object_type = "macpool.Block"
    from        = "00:25:B5:${var.pod_id}:00:01"
    size          = "1000"
    }
  organization {
    object_type = "organization.Organization"
    moid = var.organization 
    }
}
