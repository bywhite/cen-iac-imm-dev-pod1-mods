# =============================================================================
# This module creates a 6536 Cluster Domain with Chassis
# All necessary policies and profiles are created by this module
# The chassis profile uses an externally created IMC IP Pool
# -----------------------------------------------------------------------------

# =============================================================================
# Main 6536 Domain Cluster Profile
# -----------------------------------------------------------------------------
resource "intersight_fabric_switch_cluster_profile" "fi6536_cluster_profile" {
  name        = "${var.policy_prefix}-imm-domain"
  description = var.description
  type        = "instance"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
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
# 6536 Switch Profiles
# -----------------------------------------------------------------------------

### 6536 Switch Profile A ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_a" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-switch-a"
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

### 6536 Switch Profile B ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_b" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-switch-b"
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
# END of 6536 FI Cluster (Domain) and Switch Profiles Configuration
# -----------------------------------------------------------------------------
