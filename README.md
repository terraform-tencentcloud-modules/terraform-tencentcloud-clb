# TencentCloud CLB Module for Terraform

## terraform-tencentcloud-clb

A terraform module used to create TencentCloud CLB instance.

The following resources are included.

* [CLB](https://www.terraform.io/docs/providers/tencentcloud/r/clb_instance.html)

## Usage

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

## Conditional Creation

This module can create clb instance.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project_id | Id of the project within the CLB instance, '0' - Default Project. | number | null | no 
| clb_name | Name of the CLB. The name can only contain Chinese characters, English letters, numbers, underscore and hyphen '-'. | string | tf-modules-clb | no 
| clb_tags | The available tags within this CLB. | map(string) | {} | no 
| network_type | Type of CLB instance, and available values include 'OPEN' and 'INTERNAL'. | string | null | no 
| vpc_id | VPC id of the CLB. | string | null | no 
| subnet_id | Subnet id of the CLB. Effective only for CLB within the VPC. Only supports 'INTERNAL' CLBs. | string | null | no 
| security_groups | Security groups of the CLB instance. Only supports 'OPEN' CLBs. | list(string) | null | no 


## Outputs

| Name | Description |
|------|-------------|
| clb_id | Id of CLB. |
| clb_name | Name of CLB. |
| status | The status of CLB. |
| status_time | Latest state transition time of CLB. |
| create_time | Creation time of the CLB. |
| network_type | Types of CLB. |
| clb_vips | The virtual service address table of the CLB. |
| vpc_id | Id of the VPC. |
| subnet_id | Id of the subnet. |
| security_groups | Id set of the security groups. |
| tags | The available tags within this CLB. |


## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.
