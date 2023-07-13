# =============================================================================
# Server Module Outputs
# -----------------------------------------------------------------------------

output "boot_precision_policy_list" {
    description = "List of precision boot policies" 
    value       = intersight_boot_precision_policy.boot_precision_1
  }
 output "ipmioverlan_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_ipmioverlan_policy.ipmi1
 }
  output "kvm_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_kvm_policy.kvmpolicy_1
  }
  output "vmedia_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_vmedia_policy.vmedia_1
  }
  output "power_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_power_policy.server_power_x
  }
  output "access_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_access_policy.access_1
  }
  output "snmp_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_snmp_policy.server_snmp
  }
  output "syslog_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_syslog_policy.syslog_policy
  }
  output "sol_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_sol_policy.sol1
  }
  output "storage_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_storage_storage_policy.server_storage_policy1
  }
  output "bios_policy_list" {
    description = "List of precision boot policies" 
    value = intersight_bios_policy.bios_default_policy
  }
