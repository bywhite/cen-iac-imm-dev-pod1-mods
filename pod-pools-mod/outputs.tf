#__________________________________________________________
#
# IP Pool Outputs
#__________________________________________________________

output "ip_pool_moid" {
  description = "moid of the IP Pools."
  value = intersight_ippool_pool.ippool_pool.moid
}

