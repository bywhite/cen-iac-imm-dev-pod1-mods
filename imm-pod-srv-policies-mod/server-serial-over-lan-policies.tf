# =============================================================================
#  Serial Over LAN Policies
# -----------------------------------------------------------------------------

resource "intersight_sol_policy" "sol1" {
 name        = "${var.policy_prefix}-sol-01"
 description = var.description
 enabled     = false
 baud_rate   = 9600
 com_port    = "com1"
 ssh_port    = 1096
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

