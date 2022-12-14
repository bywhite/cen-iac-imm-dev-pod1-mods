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

variable "server_policy_prefix" {
  type        = string
  description = "prefix for all servers and server template created"
  #default     = "tf-server"
}
variable "description" {
  type        = string
  description = "description field for all policies"
  default     = "Created bt Terraform"
}
variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}

# =============================================================================
# Pod Pools used by server template
# -----------------------------------------------------------------------------

variable "mac_pool_moid" {
  type         = string
  description = "MAC Pool MOID"
} 

variable "imc_ip_pool_moid" {
  type = string
  description = "moid of IP_Pool to be assigned to IMC Access Policy"
}

variable "wwnn_pool_moid" {
  type = string
  description = "moid of WWNN Pool"
}

variable "wwpn_pool_a_moid" {
  type = string
  description = "moid of WWPN A fabric Pool"
}

variable "wwpn_pool_b_moid" {
  type = string
  description = "moid of WWPN B fabric Pool"
}

variable "server_uuid_pool_moid" {
  type = string
  description = "moid of UUID Pool"
}

variable "server_uuid_pool_name" {
  type = string
  description = "name of UUID Pool"
}

# =============================================================================
# Server Count
# -----------------------------------------------------------------------------

variable "server_count" {
  type = number
  description = "Number of Servers to create from server template"
}

# =============================================================================
# Server VLANs per Nic Adapter
# -----------------------------------------------------------------------------

# variable "switch_vlans_6536" {
#   type        = string
#   description = "comma separated vlans and/or vlan ranges Ex: 5,6,7,8,100-130,998-1011"
# }

variable "server_nic_vlans" {
  type        = list(map(string))
  description = "list of mapped port-names and VLAN-IDs for server template"
  # Used by Network Connectivity Policy and Eth-Network-Group Policy
  # includes "comma separated vlans and/or vlan ranges Ex: 5,6,7,8,100-130,998-1011"
  # Pairs to indicate vnic_name and its vlan ID
  # "eth0" : "42", "eth1" : "42", "eth2" : "55,58,60-72,1000-1022"
  ### OR ###
  # default   = [
  #   { "eth0" : "42", "native" : "42" },
  #   { "eth1" : "42", "native" : "42" },
  #   { "eth2" : "50,55,1000-1011", "native" : "" },
  #   { "eth3" : "50,55,1000-1011", "native" : "" }
  # ]
}


# =============================================================================
# IMC
# -----------------------------------------------------------------------------

variable "imc_access_vlan" {
  type        = number
  description = "ID of VLAN for IMC access"
}
variable "server_imc_admin_password" {
  type        = string
  description = "password for the local user policy for IMC"
  default     = "Cisco123"
}

# =============================================================================
# SNMP
# -----------------------------------------------------------------------------

variable "snmp_password" {
  type        = string
  default     = "Cisco123"
}
variable "snmp_ip"  {
  type        = string
  default     = "127.0.0.1"
}


# variable "ntp_servers" {
#   type        = list(string)
#   description = "list of NTP servers"
# }
# variable "ntp_timezone" {
#   type        = string
#   description = "valid timezone as documented at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ntp_policy"
#   default     = "America/Chicago"
# }
# variable "dns_preferred" {
#   type        = string
#   description = "IP address of primary (preferred) DNS server"
# }
# variable "dns_alternate" {
#   type        = string
#   description = "IP address of secondary (alternate) DNS server"
#   default     = ""
# }
