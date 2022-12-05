#__________________________________________________________
#
# IP Pool Outputs
#__________________________________________________________

output "ip_pools" {
  description = "moid of the IP Pools."
  value = var.ip_pools != {} ? { for v in sort(
    keys(intersight_ippool_pool.ip_pools) ) : v => intersight_ippool_pool.ip_pools[v].moid } : {}
}

