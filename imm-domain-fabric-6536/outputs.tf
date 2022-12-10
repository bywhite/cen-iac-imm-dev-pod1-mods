#__________________________________________________________
#
# Domain and Chassis Outputs
#__________________________________________________________

output "fi6536_cluster_profile_name" {
  description = "mname of domain cluster profile created"
  value       = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile.name
}

output "fi6536_cluster_profile_moid" {
  description = "moid of domain cluster profile created"
  value       = intersight_fabric_switch_cluster_profile.fi6536_cluster_profile.moid
}

output "chassis_9508_profile_moids" {
  description = "Chassis cluster profiles created"
  value       = local.chassis_profile_moids
}
