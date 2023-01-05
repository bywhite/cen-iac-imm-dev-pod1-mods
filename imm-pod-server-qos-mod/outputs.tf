#__________________________________________________________
#
# QoS System Class Outputs
#__________________________________________________________

# Fabric QoS System Class moid to be assigned to FI-A and FI-B switch profiles

output "system_qos_moid" {
  description = "moid of the Switch QoS policy."
  value = intersight_fabric_system_qos_policy.system_qos1.moid
}
output "system_qos_name" {
  description = "Name of the Switch Qos policy."
  value = intersight_fabric_system_qos_policy.system_qos1.name
}

# Eth QoS Policies
output "vnic_qos_besteffort_moid" {
  description = "Best Effort QoS moid"
  value = intersight_vnic_eth_qos_policy.vnic_qos_besteffort.moid
}
output "vnic_qos_bronze_moid" {
  description = "Bronze QoS moid"
  value = intersight_vnic_eth_qos_policy.vnic_qos_bronze.moid
}
output "vnic_qos_silver_moid" {
  description = "Silver Qos moid"
  value = intersight_vnic_eth_qos_policy.vnic_qos_silver.moid

}
output "vnic_qos_gold_moid" {
  description = "Gold Qos moid"
  value = intersight_vnic_eth_qos_policy.vnic_qos_gold.moid
}
# output "vnic_qos_platinum_moid" {
#   description = "Platinum Qos moid"
#   value = intersight_vnic_eth_qos_policy.vnic_qos_platinum.moid
# }


# Fibre Channel FC QoS (CoS 3) Policy
output "vnic_qos_fc_moid" {
  description = "Fiber Channel (FC) Qos moid"
  value = intersight_vnic_fc_qos_policy.vnic_qos_fc.moid
}

