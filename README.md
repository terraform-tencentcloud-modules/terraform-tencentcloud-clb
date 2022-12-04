# TencentCloud CLB Module for Terraform

## terraform-tencentcloud-clb

A terraform module used to create TencentCloud CLB instance.

The following resources are included.

* [CLB](https://www.terraform.io/docs/providers/tencentcloud/r/clb_instance.html)
* [CLB Listener](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener)
* [CLB Listener Rule](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener_rule)
* [CLB Log Set](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_log_set)
* [CLB Log Topic](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_log_topic)

## Usage

There are tow ways to create clb using this module:

1. Simple clb instance
2. Clb instance with HTTP listener and log

### Simple clb instance

```hcl
module "clb-instance" {
  source          = "terraform-tencentcloud-modules/clb/tencentcloud"

  network_type    = "OPEN"
  clb_name        = "tf-clb-module-open"
  vpc_id          = module.vpc.vpc_id
  project_id      = 0
  security_groups = [module.security_group.security_group_id]

  clb_tags = {
    test = "tf-clb-module"
  }
}
```

### Clb instance with HTTP listener and log

```hcl
module "clb-instance" {
  source = "terraform-tencentcloud-modules/clb/tencentcloud"

  network_type    = "OPEN"
  clb_name        = "tf-clb-module-open"
  vpc_id          = "vpc-id-123"
  project_id      = 0
  security_groups = ["security-groups-id-123"]

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

```



## Conditional Creation

This module can create clb instance.

## Inputs

| Name                         | Description                                                  |     Type     |    Default     | Required |
| ---------------------------- | ------------------------------------------------------------ | :----------: | :------------: | :------: |
| project_id                   | Id of the project within the CLB instance, '0' - Default Project. |    number    |      null      |    no    |
| clb_name                     | Name of the CLB. The name can only contain Chinese characters, English letters, numbers, underscore and hyphen '-'. |    string    | tf-modules-clb |    no    |
| clb_tags                     | The available tags within this CLB.                          | map(string)  |       {}       |    no    |
| network_type                 | Type of CLB instance, and available values include 'OPEN' and 'INTERNAL'. |    string    |      null      |    no    |
| vpc_id                       | VPC id of the CLB.                                           |    string    |      null      |    no    |
| subnet_id                    | Subnet id of the CLB. Effective only for CLB within the VPC. Only supports 'INTERNAL' CLBs. |    string    |      null      |    no    |
| security_groups              | Security groups of the CLB instance. Only supports 'OPEN' CLBs. | list(string) |      null      |    no    |
| load_balancer_pass_to_target | Whether the target allow flow come from clb. If value is true, only check security group of clb, or check both clb and backend instance security group. |     bool     |      true      |   Yes    |
| target_region_info_region    | Region information of backend services are attached the CLB instance. Only supports OPEN CLBs. |    string    |       ""       |    No    |
| clb_log_set_period           | Logset retention period in days. Maximun value is 90.        |    number    |       7        |    No    |
| clb_log_topic_name           | Log topic of CLB instance./的房间都是                        |    string    |  "clb-topic"   |    No    |
| clb_listeners                | The CLB listener list                                        | list(object) |       []       |    No    |
| clb_health_check             | The configuration of CLB listener Health check               |    object    |       {}       |    No    |
| session_expire_time          | Time of session persistence within the CLB listener. NOTES: Available when scheduler is specified as WRR, and not available when listener protocol is TCP_SSL. NOTES: TCP/UDP/TCP_SSL listener allows direct configuration, HTTP/HTTPS listener needs to be configured in tencentcloud_clb_listener_rule. |    number    |       30       |    No    |

### clb_listeners

| Name            | Description                                                  |  Type  |     Default     | Required |
| --------------- | ------------------------------------------------------------ | :----: | :-------------: | :------: |
| listener_name   | Name of the CLB listener, and available values can only be Chinese characters, English letters, numbers, underscore and hyphen '-'. | sting  | "test_listener" |    No    |
| port            | Port of the CLB listener.                                    | number |       80        |    No    |
| protocol        | Type of protocol within the listener. Valid values: TCP, UDP, HTTP, HTTPS and TCP_SSL. | string |      HTTP       |    No    |
| listener_domain | Domain name of the listener rule.                            | string |      null       |   Yes    |
| listener_url    | Url of the listener rule.                                    | string |      null       |   Yes    |

### clb_health_check

| Name                       | Description                                                  |  Type  | Default | Required |
| -------------------------- | ------------------------------------------------------------ | :----: | :-----: | :------: |
| health_check_switch        | Indicates whether health check is enabled.                   |  bool  |  true   |    No    |
| health_check_interval_time | Interval time of health check. Valid value ranges: [5~300] sec. and the default is 5 sec. NOTES: TCP/UDP/TCP_SSL listener allows direct configuration, HTTP/HTTPS listener needs to be configured in tencentcloud_clb_listener_rule. | number |   100   |    No    |
| health_check_health_num    | Health threshold of health check, and the default is 3. If a success result is returned for the health check for 3 consecutive times, the backend CVM is identified as healthy. The value range is 2-10. | number |    2    |    No    |
| health_check_unhealth_num  | Unhealthy threshold of health check, and the default is 3. If a success result is returned for the health check 3 consecutive times, the CVM is identified as unhealthy. The value range is [2-10] | number |    2    |    No    |
| health_check_http_code     | HTTP health check code of TCP listener. When the value of health_check_type of the health check protocol is HTTP, this field is required. Valid values: 1, 2, 4, 8, 16. 1 means http_1xx, 2 means http_2xx, 4 means http_3xx, 8 means http_4xx, 16 means http_5xx. | number |    2    |    No    |
| health_check_http_method   | HTTP health check method of TCP listener. Valid values: HEAD, GET. | string |  "GET"  |    No    |

## Outputs

| Name             | Description                                   |
| ---------------- | --------------------------------------------- |
| clb_id           | Id of CLB.                                    |
| clb_name         | Name of CLB.                                  |
| status           | The status of CLB.                            |
| status_time      | Latest state transition time of CLB.          |
| create_time      | Creation time of the CLB.                     |
| network_type     | Types of CLB.                                 |
| clb_vips         | The virtual service address table of the CLB. |
| vpc_id           | Id of the VPC.                                |
| subnet_id        | Id of the subnet.                             |
| security_groups  | Id set of the security groups.                |
| tags             | The available tags within this CLB.           |
| clb_listener_id  | ID of the CLB_listener.                       |
| clb_log_set_id   | The id of log set.                            |
| clb_log_topic_id | "The id of log topic."                        |


## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.