# tencentcloud clb customized config

Provides a resource to create an clb customized config. more

Reference: https://www.tencentcloud.com/document/product/214/32427?has_map=1&lang=en&pg=



## usage

```hcl

terraform {
  source = "../.."
}

inputs = {

  create = true
  config_name = "cros"
  config_content = <<EOT
add_header Access-Control-Allow-Methods 'POST, OPTIONS';
add_header Access-Control-Allow-Origin *;
EOT
  load_balancer_ids = [
    "lb-xxxxx",
    "lb-xxxxx"
  ]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.78.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >1.78.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_customized_config.config](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_customized_config) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_content"></a> [config\_content](#input\_config\_content) | Content of Customized Config. | `string` | `""` | no |
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | Name of Customized Config. | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | create or not | `bool` | `true` | no |
| <a name="input_load_balancer_ids"></a> [load\_balancer\_ids](#input\_load\_balancer\_ids) | clb ids to bind this config | `list(string)` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clb_customized_config_id"></a> [clb\_customized\_config\_id](#output\_clb\_customized\_config\_id) | n/a |
