# =============================================================================
# This module creates a 6454 Domain with Chassis Profiles
# All supporting policies and profiles are created by this module
# The IMC IP Pool moid for the chassis is provided as a variable
# Profiles created on this page:
#  - Domain Cluster Profile
#  - FI-A Switch Profile
#  - FI-B Switch Profile
# -----------------------------------------------------------------------------

# =============================================================================
# Main 6454 Domain Cluster Profile
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_cluster_profile
# -----------------------------------------------------------------------------
resource "intersight_fabric_switch_cluster_profile" "fi6454_cluster_profile" {
  name        = "${var.policy_prefix}-domain"
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
# -----------------------------------------------------------------------------


# =============================================================================
# FI-A Switch Profile
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile
# -----------------------------------------------------------------------------
resource "intersight_fabric_switch_profile" "fi6454_switch_profile_a" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-switch-a"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6454_cluster_profile.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
# -----------------------------------------------------------------------------

# =============================================================================
# FI-B Switch Profile
# Reference: https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile
# -----------------------------------------------------------------------------
resource "intersight_fabric_switch_profile" "fi6454_switch_profile_b" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-switch-b"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6454_cluster_profile.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  depends_on = [
    intersight_fabric_switch_profile.fi6454_switch_profile_a
  ]
}
# -----------------------------------------------------------------------------

# =============================================================================
# END of 6454 FI Cluster (Domain) and Switch Profiles
# -----------------------------------------------------------------------------
