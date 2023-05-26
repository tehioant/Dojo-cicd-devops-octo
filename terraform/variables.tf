variable "location" {
  type        = string
  description = "resource location in full letter. e.g.: West Europe"
}

variable "owner" {
  type        = string
  description = "who is defined as owner of the product"
}

variable "product" {
  type        = string
  description = "product name which the resource is part of. e.g.: FORMATION_TERRAFORM"
}

variable "tags" {
  type        = map(any)
  description = "All required and additional tags"
}