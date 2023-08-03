# =============================================================================
#  Variables passed to create IMM Pools for entire Pod
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
  default     = "Created by pod-pools-mod"
}
variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}

# =============================================================================
# Chassis IP Block resource values
# -----------------------------------------------------------------------------

variable "chassis_ip_start" {
    type  = string
    description = "IP Pool Starting IP Address of the block"
    default     = ""
}

variable "chassis_ip_size" {
    type  = string
    description = "Number of IP Addresses in the block"
    default     = ""
}

variable "chassis_ip_gateway" {
    type  = string
    description = "IP Pool gateway IP Address of the block"
    default     = ""
}

variable "chassis_ip_netmask" {
    type  = string
    description = "IP Pool netmask of the block"
    default     = ""
}

variable "chassis_ip_primary_dns" {
    type  = string
    description = "IP Pool Primary DNS IP Address of the block"
    default     = ""
}

