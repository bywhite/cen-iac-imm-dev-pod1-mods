# =============================================================================
# Org external references
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
# Fabric Interconnect 6536 ports and VLANs
# -----------------------------------------------------------------------------

variable "server_ports_6536" {
  type        = set(string)
  description = "list of port numbers to be assigned to server ports"
}
variable "port_channel_6536" {
  type        = set(string)
  description = "list of ethernet port numbers to be assigned to uplink port channel"
}

variable "eth_breakout_count" {
  type        = number
  description = "The number of physical ethernet ports to convert to 25G Breakouts, starting at port 1"
  default     = 0
}
variable "eth_breakout_start" {
  type        = number
  description = "The starting physical ethernet port number to use as 4x ethernet breakouts"
  default     = 29
}

variable "eth_aggr_server_ports" {
  type       = map(object({
    aggregate_port_id = string
    port_id           = string
  }))
  default = null
}

variable "switch_vlans_6536" {
  type        = string
  description = "comma separated vlans and/or vlan ranges Ex: 5,6,7,8,100-130,998-1011"
}
variable "vlan_prefix" {
  type        = string
  description = "prepended to vlan-id    EX:   vlan-123"
  default = "vlan"
}

# =============================================================================
# Fabric Interconnect 6536 SAN ports and VSANs
# -----------------------------------------------------------------------------

# FC Port Count is not currently used - FC config defined by module
variable "fc_port_count_6536" {
  type        = number
  description = "number of ports to assign to FC starting at port 35"
  default     = 2
}

variable "fc_port_channel_6536" {
  type        = list (map(number))
  default     = []
}
# variable "vsan_name_prefix" {
#   type        = string
#   default     = "vsan-"
# }
variable "fc_uplink_pc_vsan_id_a" {
  type        = number
  default     = null
}
variable "fc_uplink_pc_vsan_id_b" {
  type        = number
  default     = null
}

variable "fabric_a_vsan_sets" {
  type       = map(object({
    vsan_number  = number
    fcoe_number  = number
    switch_id    = string
  }))
  description = "Map of vSANs and FCoE VLANs for FI"
}
variable "fabric_b_vsan_sets" {
  type       = map(object({
    vsan_number  = number
    fcoe_number  = number
    switch_id    = string
  }))
  description = "Map of vSANs and FCoE VLANs for FI"
}

# =============================================================================
# Chassis
# -----------------------------------------------------------------------------

variable "chassis_9508_count" {
  type        = number
  description = "count of 9508 X-Series chassis to add to domain"
  default     = 1
}

variable "chassis_imc_access_vlan" {
  type        = number
  description = "ID of VLAN for chassis in-band IMC access"
}
variable "chassis_imc_ip_pool_moid" {
  type = string
  description = "moid of chassis ip_pool to be assigned to IMC access policy"
}


# =============================================================================
# NTP, DNS and SNMP Settings
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
variable "snmp_password" {
  type        = string
  default     = "Cisco123"
}
variable "snmp_ip"  {
  type        = string
  default     = "127.0.0.1"
}
