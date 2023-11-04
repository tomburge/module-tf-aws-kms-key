# Variables
variable "name" {
  type = string
}

variable "custom_policy" {
  type    = any
  default = null
}

variable "key_config" {
  type = object({
    delete_days  = optional(number)
    description  = optional(string)
    enable       = optional(bool)
    key_spec     = optional(string)
    multi_region = optional(bool)
    rotation     = optional(bool)
    usage        = optional(string)
  })
  default = {
    delete_days  = null
    description  = null
    enable       = null
    key_spec     = null
    multi_region = null
    rotation     = null
    usage        = null
  }
}

variable "targets" {
  type = list(object({
    target_arn  = optional(string)
    target_type = string
  }))
}

