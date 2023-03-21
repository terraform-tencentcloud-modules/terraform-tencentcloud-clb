#basic
output "with_listeners_clb_id" {
  description = "Id of CLB."
  value       = module.clb-instance-with-listeners.clb_id
}

output "with_listeners_clb_name" {
  description = "Name of CLB."
  value       = module.clb-instance-with-listeners.clb_name
}

output "with_listeners_clb_listener_id" {
  value       = module.clb-instance-with-listeners.clb_listener_id
  description = "ID of the CLB_listener."
}

#redirection
output "redirection_clb_id" {
  description = "Id of CLB."
  value       = module.clb-instance-listener-redirection.clb_id
}

output "redirection_clb_name" {
  description = "Name of CLB."
  value       = module.clb-instance-listener-redirection.clb_name
}

output "redirection_clb_listener_id" {
  value       = module.clb-instance-listener-redirection.clb_listener_id
  description = "ID of the CLB_listener."
}

output "redirection_clb_listener_rule_id" {
  value = module.clb-instance-listener-redirection.clb_listener_rule_id
  description = "ID of the CLB_Listener_rule."
}

output "redirection_clb_redirection_id" {
  value = module.clb-instance-listener-redirection.clb_redirection_id
}

#log
output "log_clb_id" {
  description = "Id of CLB."
  value       = module.clb-instance-with-log.clb_id
}

output "log_clb_name" {
  description = "Name of CLB."
  value       = module.clb-instance-with-log.clb_name
}

output "log_clb_listener_id" {
  value       = module.clb-instance-with-log.clb_listener_id
  description = "ID of the CLB_listener."
}

output "log_clb_log_set_id" {
  value       = module.clb-instance-with-log.clb_log_set_id
  description = "The id of log set."
}

output "log_clb_log_topic_id" {
  value       = module.clb-instance-with-log.clb_log_topic_id
  description = "The id of log topic."
}
