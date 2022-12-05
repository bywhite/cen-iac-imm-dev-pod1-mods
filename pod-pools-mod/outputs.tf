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
