locals {
  network = {
    vnet_id   = "vnet-123"
    subnet_id = "subnet-456"
  }
}

module "mysql_server" {
  source  = "blackbird-cloud/mysql-server/azurerm"
  version = "~> 1"

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
