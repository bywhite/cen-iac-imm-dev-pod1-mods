# =============================================================================
# vHBA FC Adapter Policy (adapter tuning per OS)
# -----------------------------------------------------------------------------

# =============================================================================
# Note:
# vnic FC Interfaces ("intersight_vnic_fc_if") like fc0, fc1, are created
# in the server template module with these resources as parameters plus the
# vnic FC QoS Policy from the imm-pod-server-qos-mod module plus the
# WWNN & WWPN pool from the imm-pod-pools-mod module
# Note: SAN Connectivity Policy is defined per Server Template
# -----------------------------------------------------------------------------


# ===============================================================================
# vnic FC Adapter Policy      HBA Adapter Settings  
## These values need updating based on Storage Platform, OS & workload
# -------------------------------------------------------------------------------
resource "intersight_vnic_fc_adapter_policy" "fc_adapter" {
  name                = "${var.policy_prefix}-fc-adapter-01"
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

