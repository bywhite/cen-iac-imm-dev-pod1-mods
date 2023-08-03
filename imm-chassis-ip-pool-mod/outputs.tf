# =============================================================================
# Chassis Pool Outputs for Pod-wide usage
#______________________________________________________________________________


output "ip_pool_chassis_moid" {
  description = "moid of the IP Pool for Chassis IMC Access Policy"
  value       = intersight_ippool_pool.ippool_pool_chassis.moid
}
output "ip_pool_chassis_name" {
  description = "moid of the IP Pool for Chassis IMC Access Policy"
  value       = intersight_ippool_pool.ippool_pool_chassis.name
}
