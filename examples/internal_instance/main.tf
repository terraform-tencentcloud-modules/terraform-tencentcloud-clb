

module "internal-clb-instance" {
  source = "../../"

  network_type    = "INTERNAL"
  clb_name        = "tf-clb-internal"
  vpc_id          = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id[0]
  project_id      = 0
  security_groups = []

  vip = "10.0.0.9"
  sla_type = "clb.c2.medium"

}


module "vpc" {
  source = "terraform-tencentcloud-modules/vpc/tencentcloud"

  vpc_name = "clb-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_is_multicast = false

  subnet_name  = "clb-vpc"
  subnet_cidrs = ["10.0.0.0/24"]
  availability_zones = ["ap-singapore-1"]
  subnet_is_multicast = false

}
