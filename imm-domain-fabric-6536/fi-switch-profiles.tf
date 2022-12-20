# =============================================================================
# IMM Cluster (Domain) and Switch Profiles for Multiple types of FI's
# Each type of FI Domain (6536 and 6454) profiles are grouped together
# Will need to pass a variable for a conditional to create a count of 1 for FI type
# A variable list of the Domain hosting type Name prefix may be needed to create
# Multiple instances with a for each statement:  [vmw-1, vmw-2]
# each could be inserted into the name of the cluster and switch profile names
#  Other Ideas
#     Could Pass FI Serial Numbers to assign profiles
# -----------------------------------------------------------------------------



# =============================================================================
# 6536 Cluster (Domain) Switch Profiles
# -----------------------------------------------------------------------------


### NEW #### 6536 Switch Profile A ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_a" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-switch-a"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile.moid
  }
  policy_bucket {
    moid        = intersight_fabric_system_qos_policy.qos1.moid
    object_type = "fabric.SystemQosPolicy"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_system_qos_policy.qos1
  ]
}

### NEW #### 6536 Switch Profile B ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_b" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-switch-b"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile.moid
  }
  policy_bucket {
    moid        = intersight_fabric_system_qos_policy.qos1.moid
    object_type = "fabric.SystemQosPolicy"
  }


  # policy_bucket = {
  #   moid        = pod_qos_moid
  #   object_type = "fabric.SystemQosPolicy"
  # }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_system_qos_policy.qos1
  ]
}


# =============================================================================
# END of 6536 FI Cluster (Domain) and Switch Profiles
# -----------------------------------------------------------------------------
