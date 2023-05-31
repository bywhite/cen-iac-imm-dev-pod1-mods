
variable "organization" {
  type = string
}

variable "pod_policy_prefix" {
  type = string
}

variable "description" {
  type        = string
  default     = "Pod IMC Default Policy"
}


variable "san_boot_targets" {
  type       = map(object({
    interface_name = string
    boot_lun       = number
    target_wwpn    = string
  }))
  description = "Map of vNic interfaces paired with their vlan range"
  default = {
    "fc0" = {
      interface_name = "fc0"
      boot_lun       = 0
      target_wwpn    = "00:00:00:00:00:00:00:00"
    }
    "fc1" = {
      interface_name = "fc1"
      boot_lun       = 0
      target_wwpn    = "00:00:00:00:00:00:00:00"
    }
  }
}
# Usage: for_each var.vsan_boot_targets  each.value["interface_name"]  each.value["boot_lun"]  each.value["target_wwpn"]
