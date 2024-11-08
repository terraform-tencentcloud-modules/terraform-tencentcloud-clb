terraform {
  source = "../../modules/customized-config"
}

inputs = {

  create = true
  config_name = "cros"
  config_content = <<EOT
add_header Access-Control-Allow-Methods 'POST, OPTIONS';
add_header Access-Control-Allow-Origin *;
EOT
  load_balancer_ids = [
    "lb-013k3ois",
    "lb-brjfkww8"
  ]
}