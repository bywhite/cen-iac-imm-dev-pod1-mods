
variable "organization" {
  type = string
}

variable "pod_policy_prefix" {
  type = string
}

variable "description" {
  type        = string
  default = "Pod Eth Network VLAN Policy"
}

variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}

variable "switch_vlans" {
  type        = string
  description = "comma separated vlans and/or vlan ranges Ex: 5,6,7,8,100-130,998-1011"
  default     = "100,101,102,313,314,997-999"
}

variable "vlan_prefix" {
  type        = string
  description = "prepended to vlan-id    EX:   vlan-123"
  default = "vlan"
}
