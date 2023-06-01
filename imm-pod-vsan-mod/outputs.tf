# This module returns the Intersight IAM End Point User Policy Moid
# for use in the Server Profile Template for IMC access


output "fc_vsan_100_moid" {
  description = "Pod MOID for VSAN 100"
  value       = intersight_vnic_fc_network_policy.fc_vsan_100.moid
}

output "fc_vsan_101_moid" {
  description = "Pod MOID for VSAN 101"
  value       = intersight_vnic_fc_network_policy.fc_vsan_101.moid
}

output "fc_vsan_102_moid" {
  description = "Pod MOID for VSAN 102"
  value       = intersight_vnic_fc_network_policy.fc_vsan_102.moid
}

output "fc_vsan_200_moid" {
  description = "Pod MOID for VSAN 200"
  value       = intersight_vnic_fc_network_policy.fc_vsan_200.moid
}

output "fc_vsan_201_moid" {
  description = "Pod MOID for VSAN 201"
  value       = intersight_vnic_fc_network_policy.fc_vsan_201.moid
}

output "fc_vsan_202_moid" {
  description = "Pod MOID for VSAN 202"
  value       = intersight_vnic_fc_network_policy.fc_vsan_202.moid
}

output "boot_policy_list" {
  description = "Boot Policy Name:Moid Pairs"
  value       = { for v in sort(keys(intersight_boot_precision_policy.san_boot_policies)) : v => intersight_boot_precision_policy.san_boot_policies[v].moid }
}
