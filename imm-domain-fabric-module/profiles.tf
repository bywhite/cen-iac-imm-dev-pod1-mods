# =============================================================================
# Switch cluster
# -----------------------------------------------------------------------------

resource "intersight_fabric_switch_cluster_profile" "fabric_switch_cluster_profile1" {
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

### NEW #### 6536 FI DOMAIN ####
resource "intersight_fabric_switch_cluster_profile" "fi6536_cluster_profile1" {
  name        = "${var.policy_prefix}-fi6536-domain"
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
  name        = "${var.policy_prefix}-domain-profile-A"
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
  name        = "${var.policy_prefix}-domain-profile-B"
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

### NEW #### 6536 Switch Profile A ####
resource "intersight_fabric_switch_profile" "fi6536_switch_profile_a" {
  action      = "No-op"
  description = var.description
  name        = "${var.policy_prefix}-6536-profile-a"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile1.moid
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
  name        = "${var.policy_prefix}-6536-profile-b"
  type        = "instance"
  switch_cluster_profile {
    moid = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile1.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

