variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the MySQL server."
}

variable "resource_group_location" {
  type        = string
  default     = "westeurope"
  description = "(Required) Location of the resource group."
}

variable "name" {
  type        = string
  description = "(Optional) The name of the MySQL server."
  default     = ""
}

variable "vnet_id" {
  type        = string
  description = "(Required)The ID of the virtual network where the MySQL server should be deployed."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the subnet where the MySQL server should be deployed."
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU name for the MySQL server."
  default     = "GP_Standard_D2ds_v4"
}

variable "mysql_version" {
  type        = string
  description = "(Optional) The version of the MySQL server."
  default     = "8.0.21"
}

variable "high_availablity" {
  type        = string
  description = "(Optional) The high availability zone for the MySQL server."
  default     = "SameZone"
}

variable "maintenance_window" {
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
  description = "(Optional) The maintenance window for the MySQL server."
  default = {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
}

variable "storage" {
  type = object({
    auto_grow_enabled  = optional(bool)
    io_scaling_enabled = optional(bool)
    iops               = optional(number)
    size_gb            = optional(number)
  })
  description = "(Optional) The storage configuration for the MySQL server."
  default = {
    auto_grow_enabled  = true
    io_scaling_enabled = false
    iops               = 360
    size_gb            = 20
  }
}
