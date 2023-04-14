
variable "organization" {
  type = string
}

variable "pod_policy_prefix" {
  type = string
}

variable "description" {
  type        = string
  default = "Pod IMC Default Policy"
}

variable "tags" {
  type        = list(map(string))
  description = "user tags to be applied to all policies"
  default     = []
}

variable "imc_admin_password" {
  type = string
}