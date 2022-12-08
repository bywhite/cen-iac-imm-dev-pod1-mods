# =============================================================================
# External Org reference
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
  description = "prefix for all policies created"
  default     = "tf"
}
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
}
variable "port_channel_6454" {
  type        = set(string)
  description = "list of port numbers to be assigned to uplink port channel"
}
variable "fc_port_count_6454" {
  type        = number
  description = "number of ports to assign to FC starting at port 35"
}
variable "uplink_vlans_6454" {
  type        = map(number)
  description = "map of vlan names and IDs to be used on FI uplinks"
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
  default     = "Ch@ng3Me"
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

