# =============================================================================
# External references
# -----------------------------------------------------------------------------

variable "organization" {
  type        = string
  description = "moid for organization in which to create the policies"
}


# =============================================================================
# Naming and tagging
# -----------------------------------------------------------------------------

variable "policy_prefix" {
  type        = string
  description = "prefix for all servers and server template created"
  default     = "pod"
}
variable "description" {
  type        = string
  description = "Common Server Pod Policy"
  default     = "Created bt Terraform"
}
variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}

# =============================================================================
# Server VLANs per Nic Adapter
# -----------------------------------------------------------------------------

variable "vlan_groups" {
  type       = map(object({
    net_group_name    = string
    native_vlan       = number
    vlan_range        = string
  }))
  description = "Map of vNic interfaces paired with their vlan range"
  default = {
    "esx7u3_v1"  = {
      net_group_name   = "vlan-group-01"
      native_vlan = 44
      vlan_range  = "44,50,1000-1011"
    }
    "winsrv2022_v1"  = {
      net_group_name   = "vlan-group-02"
      native_vlan = 44
      vlan_range  = "44,50,1000-1011"
    }
  }
}
# Usage: for_each var.vlan_groups  each.value["net_group_name"]  each.value["native_vlan"]  each.value["vlan_range"]

# =============================================================================
# IMC Access (intersight_access_policy)
# -----------------------------------------------------------------------------

variable "imc_access_vlan" {
  type        = number
  description = "ID of VLAN for IMC access"
}

variable "imc_ip_pool_moid" {
  type = string
  description = "moid of IP_Pool to be assigned to IMC Access Policy"
}


# =============================================================================
# SNMP (intersight_snmp_policy)
# -----------------------------------------------------------------------------

variable "snmp_password" {
  type        = string
  default     = "C1sc0123!"
}
variable "snmp_ip"  {
  type        = string
  default     = "10.10.10.10"
}

# =============================================================================
# Syslog (intersight_syslog_policy)
# -----------------------------------------------------------------------------

variable "syslog_remote_ip"  {
  type        = string
  default     = "10.10.10.10"
}

