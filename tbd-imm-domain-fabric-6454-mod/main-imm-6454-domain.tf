# =============================================================================
# IMM Cluster (Domain) and Switch Profiles for 6454 Fabric Interconnects
# -----------------------------------------------------------------------------



# =============================================================================
# 6454 Cluster (Domain) and Switch Profiles
# -----------------------------------------------------------------------------

resource "intersight_fabric_switch_cluster_profile" "fabric_switch_cluster_profile1" {
  name        = "${var.policy_prefix}-fi6454-domain-profile-1"
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
# Switches (A and B)
# -----------------------------------------------------------------------------

resource "intersight_fabric_switch_profile" "fi6454_switch_profile_a" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-fi6454-a-profile-1"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fabric_switch_cluster_profile1.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }

  # policy_bucket {
  #   moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.moid
  #   object_type = "fabric.EthNetworkPolicy"
  # }
  # policy_bucket {
  #   moid = intersight_fabric_port_policy.fi6454_port_policy1.moid
  #   object_type = "fabric.PortPolicy"
  # }
  # policy_bucket {
  #   moid = intersight_ntp_policy.ntp1.moid
  #   object_type = "ntp.Policy"
  # }
}
resource "intersight_fabric_switch_profile" "fi6454_switch_profile_b" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-fi6454-b-profile-1"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fabric_switch_cluster_profile1.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }

  # policy_bucket {
  #   moid = intersight_fabric_eth_network_policy.fabric_eth_network_policy1.moid
  #   object_type = "fabric.EthNetworkPolicy"
  # }
  # policy_bucket {
  #   moid = intersight_fabric_port_policy.fi6454_port_policy1.moid
  #   object_type = "fabric.PortPolicy"
  # }
  # policy_bucket {
  #   moid = intersight_ntp_policy.ntp1.moid
  #   object_type = "ntp.Policy"
  # }
}

# =============================================================================
# END of 6456 Switch Cluster (Domain) Profile
# -----------------------------------------------------------------------------

