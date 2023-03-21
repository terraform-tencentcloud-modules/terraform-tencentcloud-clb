################################################################################
# CLB Module With Listeners
################################################################################
#Note about SSL:
#The line about https/tcp_ssl is commented because certificate needs to be bound to the domain name and activated
#data "tencentcloud_ssl_certificates" "foo" {
#  name = "your ssl cert name"
#}

module "clb-instance-with-listeners" {
  source = "../../"

  network_type    = "OPEN"
  clb_name        = "tf-clb-module-with-listener"
  vpc_id          = module.vpc.vpc_id
  project_id      = 0
  security_groups = [module.security_group.security_group_id]

  clb_listeners = [
    {
      listener_name       = "tcp_listener"
      protocol            = "TCP"
      port                = 66
      session_expire_time = 30
    },
    {
      listener_name = "http_listener"
      protocol      = "HTTP"
      port          = 80
    },
#    {
#      listener_name        = "https_listener"
#      protocol             = "HTTPS"
#      port                 = 443
#      certificate_ssl_mode = "UNIDIRECTIONAL"
#      certificate_id       = data.tencentcloud_ssl_certificates.foo.certificates.0.id
#    },
#    {
#      listener_name        = "tcp_ssl_listener"
#      protocol             = "TCP_SSL"
#      port                 = 67
#      certificate_ssl_mode = "UNIDIRECTIONAL"
#      certificate_id       = data.tencentcloud_ssl_certificates.foo.certificates.0.id
#    }
  ]

  clb_tags = {
    test = "tf-clb-module"
  }
}

################################################################################
# CLB Module Listener Redirection
################################################################################

module "clb-instance-listener-redirection" {
  source = "../../"

  network_type            = "OPEN"
  clb_name                = "tf-clb-module-listener-redirection"
  vpc_id                  = module.vpc.vpc_id
  project_id              = 0
  security_groups         = [module.security_group.security_group_id]
  create_listener_rules   = true
  create_clb_redirections = true

  clb_listeners = [
    {
      listener_name = "http_listener1"
      protocol      = "HTTP"
      port          = 80
    },
    {
      listener_name = "http_listener2"
      protocol      = "HTTP"
      port          = 88
    }
  ]

  clb_tags = {
    test = "tf-clb-module"
  }

  clb_listener_rules = [
    {
      listener_index = 0
      domain         = "foo.net"
      url            = "/index"
    },
    {
      listener_index = 0
      domain         = "foo.net"
      url            = "/index1"
    },
    {
      listener_index = 1
      domain         = "foo.net"
      url            = "/index"
    }
  ]

  clb_redirections = [
    {
      source_listener_rule_index = 0
      target_listener_rule_index = 2
    }
  ]
}

################################################################################
# CLB Module With Log
################################################################################

module "clb-instance-with-log" {
  source = "../../"

  network_type       = "OPEN"
  clb_name           = "tf-clb-module-with-log"
  vpc_id             = module.vpc.vpc_id
  project_id         = 0
  security_groups    = [module.security_group.security_group_id]
  create_clb_log     = true
  clb_log_set_period = 7
  clb_log_topic_name = "clb_topic"

  clb_listeners = [
    {
      listener_name       = "tcp_listener"
      protocol            = "TCP"
      port                = 66
      session_expire_time = 30
    }
  ]

  clb_tags = {
    test = "tf-clb-module"
  }
}


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

module "security_group" {
  source = "terraform-tencentcloud-modules/security-group/tencentcloud"

  name        = "clb-security-group"
  description = "clb-security-group-test"

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

  tags = {
    module = "security-group"
  }

  security_group_tags = {
    test = "security-group"
  }
}

provider "tencentcloud" {
  region = "ap-shanghai"
}
