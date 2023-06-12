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

/*
variable "server_ports_6536" {
  type        = "map"
  description = "map of port numbers to chassis numbers"
  default     = {
    "1"  = 1
    "2"  = 1
    "3"  = 2
    "4"  = 2
    "5"  = 3
    "6"  = 3
    "7"  = 4
    "8"  = 4
    "9"  = 5
    "10" = 5
  }
}
*/


variable "server_ports_6536" {
  type        = map(string)
  description = "map of port numbers to chassis numbers"
  default     = {
    "1"  = "1"
    "2"  = "1"
    "3"  = "2"
    "4"  = "2"
    "5"  = "3"
    "6"  = "3"
    "7"  = "4"
    "8"  = "4"
    "9"  = "5"
    "10" = "5"
    "11" = "6"
    "12" = "6"
    "13" = "7"
    "14" = "7"
    "15" = "8"
    "16" = "8"
    "17" = "9"
    "18" = "9"
    "19" = "10"
    "20" = "10"
    "21" = "11"
    "22" = "11"
    "23" = "12"
    "24" = "12"
    "25" = "13"
    "26" = "13"
    "27" = "14"
    "28" = "14"
    "29" = "15"
    "30" = "15"
  }
}

/*

variable "server_ports_6536" {
  type        = set(string)
  description = "list of port numbers to be assigned to server ports"
  default     = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
}

#tonumber()
*/


variable "port_channel_6536" {
  type        = set(string)
  description = "list of ethernet port numbers to be assigned to uplink port channel"
  default     = [31, 32]
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
  default     = "100,101,102,313,314,997-999"
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
  default     = [
    { "aggport" : 35, "port" : 1 },
    { "aggport" : 35, "port" : 2 },
    { "aggport" : 35, "port" : 3 },
    { "aggport" : 35, "port" : 4 },
    { "aggport" : 36, "port" : 1 },
    { "aggport" : 36, "port" : 2 },
    { "aggport" : 36, "port" : 3 },
    { "aggport" : 36, "port" : 4 }
  ]

}

variable "fc_uplink_pc_vsan_id_a" {
  type        = number
  default     = 100
}
variable "fc_uplink_pc_vsan_id_b" {
  type        = number
  default     = 200
}

variable "fabric_a_vsan_sets" {
  type       = map(object({
    vsan_number  = number
    fcoe_number  = number
    switch_id    = string
  }))
  description = "Map of vSANs and FCoE VLANs for FI"
  default     = {
    "vsan100" = {
      vsan_number   = 100
      fcoe_number   = 1000
      switch_id      = "A"
    }
    "vsan101"  = {
      vsan_number   = 101
      fcoe_number   = 1001
      switch_id      = "A"
    }
  }
}

variable "fabric_b_vsan_sets" {
  type       = map(object({
    vsan_number  = number
    fcoe_number  = number
    switch_id    = string
  }))
  description = "Map of vSANs and FCoE VLANs for FI"
  default     = {
    "vsan200" = {
      vsan_number   = 200
      fcoe_number   = 2000
      switch_id      = "B"
    }
    "vsan201"  = {
      vsan_number   = 201
      fcoe_number   = 2001
      switch_id      = "B"
    }
  }
}

# =============================================================================
# Chassis
# -----------------------------------------------------------------------------

variable "chassis_9508_count" {
  type        = number
  description = "count of 9508 X-Series chassis to add to domain"
  default     = 15
}

variable "chassis_imc_access_vlan" {
  type        = number
  description = "ID of VLAN for chassis in-band IMC access"
  default     = 999
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
  default     = ["ca.pool.ntp.org"]
}
variable "ntp_timezone" {
  type        = string
  description = "valid timezone as documented at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ntp_policy"
  default     = "America/Chicago"
}
variable "dns_preferred" {
  type        = string
  description = "IP address of primary (preferred) DNS server"
  default     = "8.8.8.8"
}
variable "dns_alternate" {
  type        = string
  description = "IP address of secondary (alternate) DNS server"
  default     = "8.8.4.4"
}
variable "snmp_password" {
  type        = string
  default     = "Cisco123"
}
variable "snmp_ip"  {
  type        = string
  default     = "10.10.10.10"
}
