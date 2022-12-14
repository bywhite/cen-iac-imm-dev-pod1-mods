# =============================================================================
# vNic Related Server Policies
#  - QoS Policy
#  - Eth Adapter Policy (adapter tuning)
#  - vNic Eth Interface Policy
# -----------------------------------------------------------------------------



resource "intersight_vnic_eth_qos_policy" "v_eth_qos1" {
  name           = "${var.server_policy_prefix}-vnic-eth-qos"
  description    = var.description
  mtu            = 1500
  rate_limit     = 0
  cos            = 0
  burst          = 1024
  priority       = "Best Effort"
  trust_host_cos = false
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

# this policy is actually quite complex but we are taking all the defaults
# Adapter can be tuned for VMware vs Windows Bare Metal vs other (EX: tx-offload)
# could add conditional for creation based on nic_optimized_for = "vmw"
resource "intersight_vnic_eth_adapter_policy" "v_eth_adapter1" {
  name        = "${var.server_policy_prefix}-vnic-eth-adapter"
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



# =============================================================================
# vNICs
# -----------------------------------------------------------------------------
resource "intersight_vnic_eth_if" "eth0" {
  # Will need to iterate through various settings for_each eth[*]
  # count: int_name, switch_id(A/B), vnic_lan_moid[*], adapter_pol_moid[*], qos_moid[*], net_grp_moid[*], ncp_moid  
  name             = "eth0"
  order            = 0
  failover_enabled = false
  mac_address_type = "POOL"
  mac_pool {
    moid = var.mac_pool_moid
  }
  placement {
    id        = ""
    pci_link  = 0
    switch_id = "A"
    uplink    = 0
  }
  cdn {
    value     = "eth0"    #Same as vNIC Name
    nr_source = "vnic"
  }
  usnic_settings {
    cos      = 5
    nr_count = 0
  }
  vmq_settings {
    enabled             = false
    multi_queue_support = false
    num_interrupts      = 16
    num_vmqs            = 4
  }
  lan_connectivity_policy {   # Groups eth[*] interfaces together and sets FI-attached
    moid        = intersight_vnic_lan_connectivity_policy.vnic_lan_1.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_adapter_policy {        # Provides for adapter tuning to workload
    moid = intersight_vnic_eth_adapter_policy.v_eth_adapter1.id
  }
  eth_qos_policy {            # Unique per eth[*] - Sets Class of Service and MTU
    moid = intersight_vnic_eth_qos_policy.v_eth_qos1.id
  }
  fabric_eth_network_group_policy {   # Unique per eth[*] - Sets VLAN list (2,4,7,1000-1011)
    moid = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy1.moid
  }
  fabric_eth_network_control_policy {  # Sets CDP LLDP and link down behavior 
    moid = intersight_fabric_eth_network_control_policy.fabric_eth_network_control_policy1.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}



resource "intersight_vnic_eth_if" "eth1" {
  name             = "eth1"
  order            = 0
  failover_enabled = false
  mac_address_type = "POOL"
  mac_pool {
    moid = var.mac_pool_moid
  }
  placement {
    id        = ""
    pci_link  = 0
    switch_id = "B"
    uplink    = 0
  }
  cdn {
    value     = "eth1"
    nr_source = "vnic"
  }
  usnic_settings {
    cos      = 5
    nr_count = 0
  }
  vmq_settings {
    enabled             = false
    multi_queue_support = false
    num_interrupts      = 16
    num_vmqs            = 4
  }
  lan_connectivity_policy {
    moid        = intersight_vnic_lan_connectivity_policy.vnic_lan_1.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.v_eth_adapter1.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.v_eth_qos1.id
  }
  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy1.moid
  }
  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.fabric_eth_network_control_policy1.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
