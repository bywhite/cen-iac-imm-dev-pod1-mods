# =============================================================================
#  Server Access Related  Policies
#  - IMC Access Policy (IP Settings)
# -----------------------------------------------------------------------------

# =============================================================================
# IMC Access
# Sets Inband/Outband VLAN ID and IP-Pool for IMC
# -----------------------------------------------------------------------------

resource "intersight_access_policy" "access_1" {
  name        = "${var.policy_prefix}-imc-access-01"
  description = var.description
  inband_vlan = var.imc_access_vlan
  inband_ip_pool {
    object_type  = "ippool.Pool"
    moid         = var.imc_ip_pool_moid
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

