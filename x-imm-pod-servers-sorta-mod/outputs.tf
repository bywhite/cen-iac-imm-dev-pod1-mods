# =============================================================================
# Server Module Outputs
# -----------------------------------------------------------------------------


output "server_profile_template_name" {
  description = "MOID of the created server profile template"
  value       = intersight_server_profile_template.server_template_1.name
}

output "server_profile_template_moid" {
  description = "MOID of the created server profile template"
  value       = intersight_server_profile_template.server_template_1.moid
}

output "server_interfaces" {
  description = "List of created interfaces"
  value       = intersight_fabric_eth_network_group_policy.fabric_eth_network_group_policy1
}

# Output list of server_profile_list Names
output "server_profile_names" {
  description = "List of server profiles"
  value       = local.server_name_set
}
# Output list of new server_profile_list Names
output "new_server_profile_names" {
  description = "List of server profiles"
  value       = local.new_server_name_set
}
# Output list of var.old_server_profile_names
output "old_server_profile_names" {
  description = "List of existing server profiles"
  value       = var.old_server_profile_names
}