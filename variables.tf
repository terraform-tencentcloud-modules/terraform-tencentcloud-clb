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
  default     = null
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

variable "clb_log_set_period" {
  type        = number
  default     = 7
  description = "Logset retention period in days. Maximun value is 90."
}

variable "clb_log_topic_name" {
  type        = string
  default     = "clb_topic"
  description = "Log topic of CLB instance."
}

variable "log_set_id" {
  type        = string
  default     = ""
  description = "The id of log set."
}

variable "log_topic_id" {
  type        = string
  default     = ""
  description = "The id of log topic."
}

variable "create_listener" {
  type        = bool
  default     = true
  description = "Whether to create a CLB Listener."
}

variable "clb_listeners" {
  type        = list(object({
    listener_name = string
    port          = number
    protocol      = string
    listener_domain = string
    listener_url    = string
    clb_health_check = object({
      health_check_switch        = bool
      health_check_interval_time = number
      health_check_health_num    = number
      health_check_unhealth_num  = number

      health_check_http_code     = number
      health_check_http_method   = string
    })
    session_expire_time        = number
  }))
  default     = []
  description = "The CLB Listener config list."
}


