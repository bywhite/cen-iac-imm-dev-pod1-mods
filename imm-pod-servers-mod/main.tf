# =============================================================================
# The purpose of this module is to create a Server Profile Template
# The primary output is the MOID of the created server profile template
# -----------------------------------------------------------------------------



# =============================================================================
# Server Profile template
# -----------------------------------------------------------------------------

resource "intersight_server_profile_template" "server_template_1" {
  description     = var.description
  name            = "${var.server_policy_prefix}-template"
  target_platform = "FIAttached"
  uuid_address_type = "POOL"
  uuuid_pool = {
    moid        = var.uuid_pool_moid
    object_type = "uuidpool.Pool"
  } 
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

  # the following policy_bucket statements map different policies to this
  # template -- the object_type shows the policy type
  policy_bucket {
    moid        = intersight_boot_precision_policy.boot_precision_1.moid
    object_type = "boot.PrecisionPolicy"
  }
#  policy_bucket {
#    moid = intersight_ipmioverlan_policy.ipmi1.moid
#    object_type = "ipmioverlan.Policy"
#  }
  policy_bucket {
    moid = intersight_kvm_policy.kvmpolicy_1.moid
    object_type = "kvm.Policy"
  }
#  policy_bucket {
#    moid = intersight_vmedia_policy.vmedia2.moid
#    object_type = "vmedia.Policy"
#  }
  policy_bucket {
    moid = intersight_access_policy.access_1.moid
    object_type = "access.Policy"
  }
#  policy_bucket {
#    moid = intersight_iam_end_point_user_policy.user_policy1.moid
#    object_type = "iam.EndPointUserPolicy"
#  }
#  policy_bucket {
#    moid = intersight_sol_policy.sol1.moid
#    object_type = "sol.Policy"
#  }
  policy_bucket {
    moid = intersight_vnic_lan_connectivity_policy.vnic_lan_1.moid
    object_type = "vnic.LanConnectivityPolicy"
  }
}