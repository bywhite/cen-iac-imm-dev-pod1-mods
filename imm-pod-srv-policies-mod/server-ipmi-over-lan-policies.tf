# =============================================================================
#  IPMI Over LAN Policies
# -----------------------------------------------------------------------------

# =============================================================================
# IPMI over LAN (optional)   Used by Server Profile Template
# -----------------------------------------------------------------------------

resource "intersight_ipmioverlan_policy" "ipmi1" {
 description = var.description
 enabled     = false
 name        = "${var.policy_prefix}-ipmi-disabled-01"
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
