
locals {
  clb_customized_config_id = var.create ? concat(tencentcloud_clb_customized_config.config.*.id, [""])[0] : ""
  // TODO: naming convention
  config_name = var.config_name
}

resource "tencentcloud_clb_customized_config" "config" {
  count = var.create ? 1 : 0
  config_content = replace(trimsuffix(replace(var.config_content, "\r\n", "\n"), "\n"), "\n", "\r\n") # "client_max_body_size 224M;\r\nclient_body_timeout 60s;"
  config_name    = local.config_name
  load_balancer_ids = var.load_balancer_ids
}