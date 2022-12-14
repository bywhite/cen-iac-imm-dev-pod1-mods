# =============================================================================
#  Server SAN Related  Policies
#  - SAN Connectivity Policy
#  - FC Adapter Policy
#  - Network Policy
#  - FC QoS Policy
#  - FC Interface
#  - 
# -----------------------------------------------------------------------------

# =============================================================================
# SAN Connectivity   object: "vnic.SanConnectivityPolicy"
# -----------------------------------------------------------------------------

resource "intersight_vnic_san_connectivity_policy" "vnic_san_con_1" {
  name                = "${var.server_policy_prefix}-san-connectivity"
  description         = var.description
  target_platform = "FIAttached"
  placement_mode = "auto"
  wwnn_address_type = "POOL"
  wwnn_pool {
    moid = var.wwnn_pool_moid
    object_type = "fcpool.Pool"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
#   profiles {
#     moid        = var.profile
#     object_type = "server.Profile"
#   }
}



# =============================================================================
# FC Adapter Policy      HBA Adapter Settings  ## These values need updating
# -----------------------------------------------------------------------------
resource "intersight_vnic_fc_adapter_policy" "fc_adapter" {
  name                = "${var.server_policy_prefix}-fc-adapter-1"
  description         = var.description
  error_detection_timeout     = 2000
  io_throttle_count           = 256
  lun_count                   = 1024
  lun_queue_depth             = 254
  resource_allocation_timeout = 10000
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  error_recovery_settings {
    enabled           = false
    io_retry_count    = 255
    io_retry_timeout  = 50
    link_down_timeout = 240000
    port_down_timeout = 240000
    object_type       = "vnic.FcErrorRecoverySettings"
  }
  flogi_settings {
    retries     = 8
    timeout     = 4000
    object_type = "vnic.FlogiSettings"
  }
  interrupt_settings {
    mode        = "MSIx"
    object_type = "vnic.FcInterruptSettings"
  }
  plogi_settings {
    retries     = 8
    timeout     = 20000
    object_type = "vnic.PlogiSettings"
  }
  rx_queue_settings {
    ring_size   = 128
    object_type = "vnic.FcQueueSettings"
  }
  tx_queue_settings {
    ring_size   = 128
    object_type = "vnic.FcQueueSettings"
  }
  scsi_queue_settings {
    nr_count    = 8
    ring_size   = 152
    object_type = "vnic.ScsiQueueSettings"
  }
}


# =============================================================================
# FC Network Policy
# -----------------------------------------------------------------------------
resource "intersight_vnic_fc_network_policy" "v_fc_network_a1" {
  name                = "${var.server_policy_prefix}-fc-network-a1"
  description         = var.description
  vsan_settings {
    id          = 100
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

}
resource "intersight_vnic_fc_network_policy" "v_fc_network_b1" {
  name                = "${var.server_policy_prefix}-fc-network-b1"
  description         = var.description
  vsan_settings {
    id          = 200
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# =============================================================================
# FC QoS Policy
# -----------------------------------------------------------------------------
resource "intersight_vnic_fc_qos_policy" "v_fc_qos1" {
  name                = "${var.server_policy_prefix}-fc-qos1"
  description         = var.description
  burst               = 10240
  rate_limit          = 0
  cos                 = 3
  max_data_field_size = 2112
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

# =============================================================================
# FC Interface
# -----------------------------------------------------------------------------


# resource "intersight_vnic_fc_if" "vhbas" {
#   depends_on = [
#     local.org_moid,
#     intersight_fabric_fc_zone_policy.fc_zone_policies,
#     intersight_vnic_fc_adapter_policy.fibre_channel_adapter_policies,
#     intersight_vnic_fc_network_policy.fibre_channel_network_policies,
#     intersight_vnic_fc_qos_policy.fibre_channel_qos_policies,
#     intersight_vnic_san_connectivity_policy.san_connectivity_policies
#   ]
#   for_each            = local.vhbas
#   name                = each.value.name
#   order               = each.value.placement_pci_order
#   persistent_bindings = each.value.persistent_lun_bindings
#   static_wwpn_address = each.value.wwpn_allocation_type == "STATIC" ? each.value.wwpn_static_address : ""
#   type                = each.value.vhba_type
#   wwpn_address_type   = each.value.wwpn_allocation_type
#   fc_adapter_policy {
#     moid = intersight_vnic_fc_adapter_policy.fibre_channel_adapter_policies[
#       each.value.fibre_channel_adapter_policy
#     ].moid
#   }
#   fc_network_policy {
#     moid = intersight_vnic_fc_network_policy.fibre_channel_network_policies[
#       each.value.fibre_channel_network_policy
#     ].moid
#   }
#   fc_qos_policy {
#     moid = intersight_vnic_fc_qos_policy.fibre_channel_qos_policies[
#       each.value.fibre_channel_qos_policy
#     ].moid
#   }
#   san_connectivity_policy {
#     moid = intersight_vnic_san_connectivity_policy.san_connectivity_policies[
#       each.value.san_connectivity_policy
#     ].moid
#   }
#   placement {
#     id        = each.value.placement_slot_id
#     pci_link  = each.value.placement_pci_link
#     switch_id = each.value.placement_switch_id
#     uplink    = each.value.placement_uplink_port
#   }
#   dynamic "fc_zone_policies" {
#     for_each = toset(each.value.fc_zone_policies)
#     content {
#       moid = intersight_fabric_fc_zone_policy.fc_zone_policies[fc_zone_policies.value].moid
#     }
#   }
#   dynamic "wwpn_pool" {
#     for_each = each.value.wwpn_allocation_type == "POOL" ? [local.wwpn_pools[each.value.wwpn_pool]] : []
#     content {
#       moid = wwpn_pool.value
#     }
#   }
# }

# NOTES
        #   fc_zone_policies             = []
        #   fibre_channel_adapter_policy = "**REQUIRED**"
        #   fibre_channel_network_policy = "**REQUIRED**"
        #   fibre_channel_qos_policy     = "**REQUIRED**"
        #   name                         = "vhba"
        #   persistent_lun_bindings      = false
        #   placement_pci_link           = 0
        #   placement_pci_order          = 0
        #   placement_slot_id            = "MLOM"
        #   placement_switch_id          = "None"
        #   placement_uplink_port        = 0
        #   vhba_type                    = "fc-initiator"
        #   wwpn_allocation_type         = "POOL"
        #   wwpn_pool                    = ""
        #   wwpn_static_address          = ""
