#__________________________________________________________
#
# IP Pool Outputs
#__________________________________________________________

output "ip_pool_moid" {
  description = "moid of the IP Pool."
  value = intersight_ippool_pool.ippool_pool.moid
}

output "mac_pool_moid" {
  description = "moid of the MAC Pool."
  value = intersight_macpool_pool.macpool_pool1.moid
}

output "wwnn_pool_moid" {
  description = "moid of the WWNN Pool"
  value = intersight_fcpool_pool.wwnnpool_pool1.moid
}

output "wwpn_pool_a_moid" {
  description = "moid of the WWWPN-A pool"
  value = intersight_fcpool_pool.wwpnpool_poolA.moid
}

output "wwpn_pool_b_moid" {
  description = "moid of the WWWPN-B pool"
  value = intersight_fcpool_pool.wwpnpool_poolB.moid
}
