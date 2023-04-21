# This module returns the Intersight IAM End Point User Policy Moid
# for use in the Server Profile Template for IMC access


output "fi_network_vlan_policy_moid" {
  description = "Network Policy for VLANs used by FI"
  value       = fi_eth_network_policy.network_vlan_policy.moid
}
