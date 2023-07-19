# =============================================================================
# vNic Eth Adapter Policy (adapter tuning)
# -----------------------------------------------------------------------------
# this policy is actually quite complex but we are taking all the defaults
# Adapter can be tuned for VMware vs Windows Bare Metal vs other (EX: tx-offload)
resource "intersight_vnic_eth_adapter_policy" "v_eth_adapter1" {
  name        = "${var.policy_prefix}-vnic-eth-adapter-00"
  description = var.description
  organization {
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
