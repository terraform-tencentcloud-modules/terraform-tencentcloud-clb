variable "region" {
  description = "TencentCloud region to launch resources."
  type        = string
  default     = "ap-guangzhou"
}

variable "project_id" {
  description = "Id of the project within the CLB instance, '0' - Default Project."
  type        = number
  default     = null
}

# clb variables
variable "clb_name" {
  description = "Name of the CLB. The name can only contain Chinese characters, English letters, numbers, underscore and hyphen '-'."
  type        = string
  default     = "tf-modules-clb"
}

variable "clb_tags" {
  description = "The available tags within this CLB."
  type        = map(string)
  default     = {}
}

variable "network_type" {
  description = "Type of CLB instance, and available values include 'OPEN' and 'INTERNAL'."
  type        = string
  default     = "OPEN"
}

variable "vpc_id" {
  description = "VPC id of the CLB, must be same as instances' which will attached to this CLB instance."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet id of the CLB. Effective only for CLB within the VPC. Only supports 'INTERNAL' CLBs."
  type        = string
  default     = null
}

variable "security_groups" {
  description = "Security groups of the CLB instance. Only supports 'OPEN' CLBs."
  type        = list(string)
  default     = null
}