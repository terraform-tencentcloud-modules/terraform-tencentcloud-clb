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

data "tencentcloud_security_groups" "foo" {
  name       = "default"
  project_id = 0
}

module "security_group" {
  source = "terraform-tencentcloud-modules/security-group/tencentcloud"

  security_group_name        = "simple-security-group"
  security_group_description = "simple-security-group-test"

  ingress_with_cidr_blocks = [
    {
      cidr_block = "10.0.0.0/16"
    },
    {
      port       = "80"
      cidr_block = "10.1.0.0/16"
    },
    {
      port       = "808"
      cidr_block = "10.2.0.0/16"
      policy     = "drop"
    },
    {
      port       = "8088"
      protocol   = "UDP"
      cidr_block = "10.3.0.0/16"
      policy     = "accept"
    },
    {
      port        = "8080-9090"
      protocol    = "TCP"
      cidr_block  = "10.4.0.0/16"
      policy      = "accept"
      description = "simple-security-group"
    },
  ]

  egress_with_cidr_blocks = [
    {
      cidr_block = "10.0.0.0/16"
    },
    {
      port       = "80"
      cidr_block = "10.1.0.0/16"
    },
    {
      port       = "808"
      cidr_block = "10.2.0.0/16"
      policy     = "drop"
    },
    {
      port       = "8088"
      protocol   = "UDP"
      cidr_block = "10.3.0.0/16"
      policy     = "accept"
    },
    {
      port        = "8080-9090"
      protocol    = "TCP"
      cidr_block  = "10.4.0.0/16"
      policy      = "accept"
      description = "simple-security-group"
    },
  ]

  ingress_with_source_sgids = [
    {
      source_sgid = data.tencentcloud_security_groups.foo.security_groups.0.security_group_id
    },
    {
      port        = "8080-9090"
      protocol    = "TCP"
      source_sgid = data.tencentcloud_security_groups.foo.security_groups.0.security_group_id
      policy      = "accept"
      description = "simple-security-group"
    },
  ]

  egress_with_source_sgids = [
    {
      source_sgid = data.tencentcloud_security_groups.foo.security_groups.0.security_group_id
    },
    {
      port        = "8080-9090"
      protocol    = "TCP"
      source_sgid = data.tencentcloud_security_groups.foo.security_groups.0.security_group_id
      policy      = "accept"
      description = "simple-security-group"
    },
  ]

  tags = {
    module = "security-group"
  }

  security_group_tags = {
    test = "security-group"
  }
}

module "clb-instance" {
  source = "terraform-tencentcloud-modules/clb/tencentcloud"

  network_type    = "OPEN"
  clb_name        = "tf-clb-module-open"
  vpc_id          = module.vpc.vpc_id
  project_id      = 0
  security_groups = [module.security_group.security_group_id]

  clb_tags = {
    test = "tf-clb-module"
  }
}
