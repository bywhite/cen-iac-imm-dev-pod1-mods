# =============================================================================
# This Module creates a 6536 Cluster (Domain) Profile, switch profiles,
# the requested number of chassis, and their required supporting policies.
# -----------------------------------------------------------------------------

### FI 6536 DOMAIN Profile  (cluster_profile) ####
resource "intersight_fabric_switch_cluster_profile" "fi6536_cluster_profile" {
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
