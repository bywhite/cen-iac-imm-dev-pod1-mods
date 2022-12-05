# This file creates the following pools:
#    - IP pool for IMC Access
#    - MAC pool for vNICs
#    - WWNN, WWPN-A and WWPN-B FC pools


# Create a sequential WWNN and two WWPN (A and B fabirc) pool for vHBAs. Change the from and size to what you would like
#
# Comment out from here down to the end of the file if you do not want WWNN, WWPN-A and WWPN-B pools created

resource "intersight_fcpool_pool" "fcpool_pool0" {
  name = "${var.policy_prefix}-wwnn-pool"
  description = var.description
  assignment_order = "sequential"
  pool_purpose = "WWNN"
  id_blocks {
    #from        = "20:00:00:CA:FE:00:00:01"
    from        = var.wwnn-block
    size        =  255
    }
  organization {
    object_type = "organization.Organization"
    moid = var.organization 
    }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "intersight_fcpool_pool" "fcpool_pool1" {
  name = "${var.policy_prefix}-wwpn-a-pool"
  description = var.description
  assignment_order = "sequential"
  pool_purpose = "WWPN"
  id_blocks {
    from        = var.wwpn-a-block
    size        =  255
    }
  organization {
    object_type = "organization.Organization"
    moid = var.organization 
    }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

resource "intersight_fcpool_pool" "fcpool_pool2" {
  name = "${var.policy_prefix}-wwpn-b-pool"
  description = var.description
  assignment_order = "sequential"
  pool_purpose = "WWPN"
  id_blocks {
    from        = var.wwpn-b-block
    size        =  255
    }
  organization {
    object_type = "organization.Organization"
    moid = var.organization 
    }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
 