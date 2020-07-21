resource "tencentcloud_clb_instance" "this" {
  project_id      = var.project_id
  clb_name        = var.clb_name
  tags            = var.clb_tags
  network_type    = var.network_type
  vpc_id          = var.vpc_id == null ? 0 : var.vpc_id
  subnet_id       = var.vpc_id != null ? var.subnet_id : null
  security_groups = var.security_groups
}

data "tencentcloud_clb_instances" "this" {
  clb_id = local.clb_id
}

locals {
  this_clb_info = data.tencentcloud_clb_instances.this.clb_list
  clb_id        = tencentcloud_clb_instance.this.id
}
