resource "tencentcloud_clb_instance" "this" {
  project_id      = var.project_id
  clb_name        = var.clb_name
  tags            = var.clb_tags
  network_type    = var.network_type
  vpc_id          = var.vpc_id == null ? 0 : var.vpc_id
  subnet_id       = var.vpc_id != null ? var.subnet_id : null
  security_groups = var.security_groups

  log_set_id      = var.log_set_id == "" ? "${tencentcloud_clb_log_set.set[0].id}" : var.log_set_id
  log_topic_id    = var.log_topic_id == "" ? "${tencentcloud_clb_log_topic.topic[0].id}" : var.log_topic_id
}

data "tencentcloud_clb_instances" "this" {
  clb_id = local.clb_id
}

locals {
  this_clb_info = data.tencentcloud_clb_instances.this.clb_list
  clb_id        = tencentcloud_clb_instance.this.id
}
resource "tencentcloud_clb_log_set" "set" {
  count     = var.log_set_id == "" ? 1 : 0
  period    = var.clb_log_set_period
}

resource "tencentcloud_clb_log_topic" "topic" {
  count      = var.log_topic_id == "" ? 1 : 0
  log_set_id = "${tencentcloud_clb_log_set.set[0].id}"
  topic_name = var.clb_log_topic_name
}

resource "tencentcloud_clb_listener" "HTTP_listener" {
  count         = var.create_listener ? length(var.clb_listeners) : 0
  clb_id        = "${tencentcloud_clb_instance.this.id}"
  listener_name = var.clb_listeners[count.index].listener_name
  port          = var.clb_listeners[count.index].port
  protocol      = var.clb_listeners[count.index].protocol

}
resource "tencentcloud_clb_listener_rule" "HTTP_listener_rule" {
  count                      = var.create_listener ? length(var.clb_listeners) : 0
  listener_id                = "${tencentcloud_clb_listener.HTTP_listener[count.index].listener_id}"
  clb_id                     = "${tencentcloud_clb_instance.this.id}"

  domain                     = lookup(var.clb_listeners[count.index], "listener_domain", "foo.net")
  url                        = lookup(var.clb_listeners[count.index], "listener_url", "/index")
  health_check_switch        = lookup(var.clb_listeners[count.index].clb_health_check, "health_check_switch", true)
  health_check_interval_time = lookup(var.clb_listeners[count.index].clb_health_check, "health_check_interval_time", 5)
  health_check_health_num    = lookup(var.clb_listeners[count.index].clb_health_check, "health_check_health_num", 3)
  health_check_unhealth_num  = lookup(var.clb_listeners[count.index].clb_health_check, "health_check_unhealth_num", 3)
  health_check_http_code     = lookup(var.clb_listeners[count.index].clb_health_check, "health_check_http_code", 2)
  health_check_http_method   = lookup(var.clb_listeners[count.index].clb_health_check, "health_check_http_method", "GET")
  session_expire_time        = lookup(var.clb_listeners[count.index], "session_expire_time", 30)
  
}