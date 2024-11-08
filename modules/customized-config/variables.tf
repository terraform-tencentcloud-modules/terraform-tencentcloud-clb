variable "region" {
  type    = string
  default = "ap-jakarta"
}

variable "create" {
  type =bool
  default =  true
  description = "create or not"
}

variable "config_name" {
  type = string
  default = ""
  description = "Name of Customized Config."
}
variable "config_content" {
  type = string
  default = ""
  description = "Content of Customized Config."
}
variable "load_balancer_ids" {
  type = list(string)
  default = null
  description = "clb ids to bind this config"
}