

module "internal-clb-instance" {
  source = "../../"

  network_type    = "OPEN"
  clb_name        = "tf-clb-external"
  vpc_id          = module.vpc.vpc_id
  project_id      = 0
  security_groups = []

#  vip = "10.0.0.9"

}


module "vpc" {
  source = "terraform-tencentcloud-modules/vpc/tencentcloud"

  vpc_name = "clb-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_is_multicast = false

}
