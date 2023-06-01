
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

variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}

variable "san_boot_policies" {
  type       = map(object({
    device_name_1 = string
    int_name_1    = string
    boot_lun_1    = number
    target_wwpn_1 = string
    device_name_2 = string
    int_name_2    = string
    boot_lun_2    = number
    target_wwpn_2 = string
    device_name_3 = string
    int_name_3    = string
    boot_lun_3    = number
    target_wwpn_3 = string
    device_name_4 = string
    int_name_4    = string
    boot_lun_4    = number
    target_wwpn_4 = string
  }))
  description = "Map of boot policies each with their 4 boot targets"
  default = {
    "boot-11" = {
      device_name_1    = "vHBA0-Primary"
      int_name_1       = "fc0"
      boot_lun_1       = 0
      target_wwpn_1    = "20:11:00:00:00:00:00:4B"
      device_name_2    = "vHBA0-Secondary"
      int_name_2       = "fc0"
      boot_lun_2       = 0
      target_wwpn_2    = "20:12:00:00:00:00:00:4B"
      device_name_3    = "vHBA1-Primary"
      int_name_3       = "fc1"
      boot_lun_3       = 0
      target_wwpn_3    = "20:13:00:00:00:00:00:4B"
      device_name_4    = "vHBA1-Secondary"
      int_name_4       = "fc1"
      boot_lun_4       = 0
      target_wwpn_4    = "20:14:00:00:00:00:00:4B"
    }
    "boot-12" = {
      device_name_1    = "vHBA0-Primary"
      int_name_1       = "fc0"
      boot_lun_1       = 0
      target_wwpn_1    = "20:12:00:00:00:00:00:4B"
      device_name_2    = "vHBA0-Secondary"
      int_name_2       = "fc0"
      boot_lun_2       = 0
      target_wwpn_2    = "20:15:00:00:00:00:00:4B"
      device_name_3    = "vHBA1-Primary"
      int_name_3       = "fc1"
      boot_lun_3       = 0
      target_wwpn_3    = "20:23:00:00:00:00:00:4B"
      device_name_4    = "vHBA1-Secondary"
      int_name_4       = "fc1"
      boot_lun_4       = 0
      target_wwpn_4    = "20:11:00:00:00:00:00:4B"
    }
  }
}
# Usage: for_each var.san_boot_policies  each.value["interface_name"]  each.value["boot_lun"]  each.value["target_wwpn"]
