module "vpc" {
  source = "terraform-tencentcloud-modules/vpc/tencentcloud"

  vpc_name = "clb-vpc"
  vpc_cidr = "10.0.0.0/16"

  subnet_name  = "clb-vpc"
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

  security_group_name        = "clb-security-group"
  security_group_description = "clb-security-group-test"

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
  source = "../../"

  network_type    = "OPEN"
  clb_name        = "tf-clb-module-open"
  vpc_id          = module.vpc.vpc_id
  project_id      = 0
  security_groups = [module.security_group.security_group_id]

  clb_log_set_period           = 7
  clb_log_topic_name           = "clb_topic"

  clb_listeners = [
    {
      listener_name                = "http_listener"
      protocol                     = "HTTP"
      port                         = 80

      listener_domain            = "foo.net"
      listener_url               = "/index"
      clb_health_check             = {
        health_check_switch        = true
        health_check_interval_time = 100
        health_check_health_num    = 2
        health_check_unhealth_num  = 3
        health_check_http_code     = 2
        health_check_http_method   = "GET"
      }
      session_expire_time        = 30
    },
    {
      listener_name                = "http_listener2"
      protocol                     = "HTTP"
      port                         = 440
      listener_domain              = "foo2.net"
      listener_url                 = "/index"
      clb_health_check             = {
        health_check_switch        = true
        health_check_interval_time = 5
        health_check_health_num    = 4
        health_check_unhealth_num  = 4
        health_check_http_code     = null
        health_check_http_method   = null
      }
      session_expire_time        = 30
    }
  ]
  clb_tags = {
    test = "tf-clb-module"
  }
}
