
variable "vpc-config" {
  description = "values for VPC configuration"

  type = object({
    name  =    string
    cidr  =    string
  })

  validation {
    condition = can(cidrnetmask(var.vpc-config.cidr))
    error_message = "The CIDR block must be a valid CIDR notation. - ${var.vpc-config.cidr}"
  }
}

variable "subnet_config" {
  description = "values for subnet configuration like cidr and az"
  type = map(object({
    cidr = string
    az = string
    public = optional(bool,false) # default to false if not specified
  }))

  validation {
    condition = alltrue([for x in var.subnet_config : can(cidrnetmask(x.cidr))]) 
    error_message = "The CIDR block must be a valid CIDR notation. "
  }
}