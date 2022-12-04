output "clb_id" {
  description = "Id of CLB."
  value       = module.clb-instance.clb_id
}

output "clb_name" {
  description = "Name of CLB."
  value       = module.clb-instance.clb_name
}

output "clb_listener_id" {
  value       = module.clb-instance.clb_listener_id
  description = "ID of the CLB_listener."
}
output "clb_log_set_id" {
  value       = module.clb-instance.clb_log_set_id
  description = "The id of log set."
}
output "clb_log_topic_id" {
  value       = module.clb-instance.clb_log_topic_id
  description = "The id of log topic."
}
