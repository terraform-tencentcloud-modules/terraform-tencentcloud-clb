module "vpc" {
  source = "terraform-tencentcloud-modules/vpc/tencentcloud"

  vpc_name = "simple-vpc"
  vpc_cidr = "10.0.0.0/16"

  subnet_name  = "simple-vpc"
  subnet_cidrs = ["10.0.0.0/24"]

  destination_cidrs = ["1.0.1.0/24"]
  next_type         = ["EIP"]
  next_hub          = ["0"]

  tags = {
    module = "vpc"
  }

  vpc_tags = {
    test = "vpc"
  }

  subnet_tags = {
    test = "subnet"
  }
}

module "clb-instance" {
  source = "terraform-tencentcloud-modules/clb/tencentcloud"

  network_type = "INTERNAL"
  clb_name     = "tf-clb-module-internal"
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.subnet_id[0]
  project_id   = 0

  clb_tags = {
    test = "tf-clb-module"
  }
}
