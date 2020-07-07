output "clb_id" {
  description = "Id of CLB."
  value       = local.clb_id
}

output "clb_name" {
  description = "Name of CLB."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].clb_name : ""
}

output "status" {
  description = "The status of CLB."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].status : null
}

output "status_time" {
  description = "Latest state transition time of CLB."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].status_time : ""
}

output "create_time" {
  description = "Creation time of the CLB."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].create_time : ""
}

output "network_type" {
  description = "Types of CLB."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].network_type : ""
}

output "clb_vips" {
  description = "The virtual service address table of the CLB."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].clb_vips : []
}

output "vpc_id" {
  description = "Id of the VPC."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].vpc_id : ""
}

output "subnet_id" {
  description = "Id of the subnet."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].subnet_id : ""
}

output "security_groups" {
  description = "Id set of the security groups."
  value       = length(local.this_clb_info) > 0 ? local.this_clb_info[0].security_groups : []
}

output "tags" {
  description = "The available tags within this CLB."
  value       = length(local.this_clb_info) > 0 ? merge(local.this_clb_info[0].tags, {}) : {}
}