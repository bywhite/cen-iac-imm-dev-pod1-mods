#__________________________________________________________
#
# Server Template moid
#__________________________________________________________

output "server_profile_template_name" {
  description = "MOID of the created server profile template"
  value       = intersight_server_profile_template.server_template_1.name
}

output "server_profile_template_moid" {
  description = "MOID of the created server profile template"
  value       = intersight_server_profile_template.server_template_1.moid
}

# Optionally output list of Server Profile Names and MOIDs created
