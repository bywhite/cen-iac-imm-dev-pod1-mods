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
# 6536 Cluster (Domain) and Switch Profiles
# -----------------------------------------------------------------------------

### FI 6536 DOMAIN Profile  (cluster_profile) ####
resource "intersight_fabric_switch_cluster_profile" "fi6536_cluster_profile" {
  name        = "${var.policy_prefix}-Domain-Profile"
  description = var.description
  type        = "instance"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

  # switch_profiles {
  #   moid        = intersight_fabric_switch_profile.fi6536_switch_profile_a.moid
  #   object_type = "fabric.SwitchProfile"
  # }
  # switch_profiles {
  #   moid        = intersight_fabric_switch_profile.fi6536_switch_profile_b.moid
  #   object_type = "fabric.SwitchProfile"
  # }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


### NEW #### 6536 Switch Profile A ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_a" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-Switch-Profile-A"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

### NEW #### 6536 Switch Profile B ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_b" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-Switch-Profile-B"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


# =============================================================================
# END of 6536 FI Cluster (Domain) and Switch Profiles
# -----------------------------------------------------------------------------
