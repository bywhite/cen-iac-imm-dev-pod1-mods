# =============================================================================
# External references
# -----------------------------------------------------------------------------

variable "organization" {
  type        = string
  description = "moid for organization in which to create the policies"
}


# variable "wwnn-block" {
#   type         = string
#   description  = "beginning WWNN block of size 255"
#   default      = "20:00:00:CA:FE:00:00:01"
# }

# variable "wwpn-a-block" {
#   type         = string
#   description  = "beginning WWPN-A block of size 255"
#   default      = "20:00:00:CA:FE:0A:00:01"
# }

# variable "wwpn-b-block" {
#   type         = string
#   description  = "beginning WWPN-B block of size 255"
#   default      = "20:00:00:CA:FE:0B:00:01"
# }

# =============================================================================
# Naming and tagging
# -----------------------------------------------------------------------------

variable "policy_prefix" {
  type        = string
  description = "prefix for all policies created"
  default     = "tf"
}

### domain_instances are NOT USED when creating 1 domain per module call, to increases customization
# variable "domain_instances" {
#   type        = list(string)
#   description = "list of domain instances to be created [vmw-1,lnx-1,bml-1,vmw-2]"
#   default     = ["vmw-1"]
#   # Each domain-instance is concatenated with the policy_prefix to Name the domain
# }

variable "description" {
  type        = string
  description = "description field for all policies"
  default     = ""
}
variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}


# =============================================================================
# Fabric Interconnect 6454 ports and VLANs
# -----------------------------------------------------------------------------

variable "server_ports_6454" {
  type        = set(string)
  description = "list of port numbers to be assigned to server ports"
  default     = []
}
variable "port_channel_6454" {
  type        = set(string)
  description = "list of port numbers to be assigned to uplink port channel"
  default     = []
}
variable "fc_port_count_6454" {
  type        = number
  description = "number of ports to assign to FC starting at port 35"
  default     = []
}
variable "uplink_vlans_6454" {
  type        = map(number)
  description = "map of vlan names and IDs to be used on FI uplinks"
  default     = []
}
variable "vnic_native_vlan" {
  type        = number
  description = "native VLAN for vnic profiles"
  default     = []
}

# =============================================================================
# Fabric Interconnect 6536 ports and VLANs
# -----------------------------------------------------------------------------

variable "server_ports_6536" {
  type        = set(string)
  description = "list of port numbers to be assigned to server ports"
  default     = []
}
variable "port_channel_6536" {
  type        = set(string)
  description = "list of port numbers to be assigned to uplink port channel"
  default     = []
}
variable "fc_port_count_6536" {
  type        = number
  description = "number of ports to assign to FC starting at port 35"
  default     = []
}
variable "uplink_vlans_6536" {
  type        = map(number)
  description = "map of vlan names and IDs to be used on FI uplinks"
  default     = []
}
variable "vnic_native_vlan" {
  type        = number
  description = "native VLAN for vnic profiles"
  default     = []
}


# =============================================================================
# IMC
# -----------------------------------------------------------------------------

variable "imc_access_vlan" {
  type        = number
  description = "ID of VLAN for IMC access"
}
variable "imc_admin_password" {
  type        = string
  description = "password for the local user policy for IMC"
  default     = "Cha@ng3Me"
}

# =============================================================================
# Chassis Access - IMC
# -----------------------------------------------------------------------------

variable "chassis_imc_access_vlan" {
  type        = number
  description = "ID of VLAN for Chassis In-Band IMC access"
}

variable "chassis_imc_ip_pool_moid" {
  type = string
  description = "moid of Chassis IP_Pool to be assigned to IMC Access Policy"
}



# =============================================================================
# Pools 
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


# =============================================================================
# IPs
# -----------------------------------------------------------------------------

variable "ntp_servers" {
  type        = list(string)
  description = "list of NTP servers"
}
variable "ntp_timezone" {
  type        = string
  description = "valid timezone as documented at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ntp_policy"
  default     = "America/Chicago"
}
variable "dns_preferred" {
  type        = string
  description = "IP address of primary (preferred) DNS server"
}
variable "dns_alternate" {
  type        = string
  description = "IP address of secondary (alternate) DNS server"
  default     = ""
}
