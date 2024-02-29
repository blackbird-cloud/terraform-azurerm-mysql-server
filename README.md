# <Cloud> <Main resource> Terraform module
A Terraform module which configures your <Cloud> <Main resource>. <Relevant docs>
[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://www.blackbird.cloud)

## Example
```hcl
locals {
  network = {
    vnet_id   = "vnet-123"
    subnet_id = "subnet-456"
  }
}

module "mysql_server" {
  source = ".."

  resource_group_name     = "myresourcegroup"
  resource_group_location = "westeurope"

  vnet_id   = local.network.vnet_id
  subnet_id = local.network.subnet_id

  sku = "GP_Standard_D2ds_v4"

  name = "mysqlserver"

  maintenance_window = {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }

  storage = {
    iops    = 360
    size_gb = 20
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3 |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3 |

## Resources

| Name | Type |
|------|------|
| [azurerm_mysql_flexible_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_private_dns_zone.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_high_availablity"></a> [high\_availablity](#input\_high\_availablity) | (Optional) The high availability zone for the MySQL server. | `string` | `"SameZone"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) The maintenance window for the MySQL server. | <pre>object({<br>    day_of_week  = number<br>    start_hour   = number<br>    start_minute = number<br>  })</pre> | <pre>{<br>  "day_of_week": 0,<br>  "start_hour": 8,<br>  "start_minute": 0<br>}</pre> | no |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | (Optional) The version of the MySQL server. | `string` | `"8.0.21"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the MySQL server. | `string` | `""` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | (Required) Location of the resource group. | `string` | `"westeurope"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the MySQL server. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU name for the MySQL server. | `string` | `"GP_Standard_D2ds_v4"` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | (Optional) The storage configuration for the MySQL server. | <pre>object({<br>    auto_grow_enabled  = optional(bool)<br>    io_scaling_enabled = optional(bool)<br>    iops               = optional(number)<br>    size_gb            = optional(number)<br>  })</pre> | <pre>{<br>  "auto_grow_enabled": true,<br>  "io_scaling_enabled": false,<br>  "iops": 360,<br>  "size_gb": 20<br>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the subnet where the MySQL server should be deployed. | `string` | n/a | yes |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | (Required)The ID of the virtual network where the MySQL server should be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_login"></a> [admin\_login](#output\_admin\_login) | The admin username for the MySQL server. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password for the MySQL server. |
| <a name="output_azurerm_mysql_flexible_server"></a> [azurerm\_mysql\_flexible\_server](#output\_azurerm\_mysql\_flexible\_server) | The name of the MySQL Flexible Server. |
| <a name="output_mysql_flexible_server_database_name"></a> [mysql\_flexible\_server\_database\_name](#output\_mysql\_flexible\_server\_database\_name) | The name of the MySQL Flexible Server Database. |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://www.blackbird.cloud)
