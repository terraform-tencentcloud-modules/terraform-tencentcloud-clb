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

