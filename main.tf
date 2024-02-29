# Generate random value for the name
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

# locals {
#   name = var.name != "" ? "${var.name}${random_string.name.result}" : random_string.name.result
# }

# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "default" {
  name                = "${random_string.name.result}.${var.name}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "mysqlfsVnetZone-${var.name}-${random_string.name.result}.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
}

# Manages the MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "default" {
  location               = var.resource_group_location
  name                   = "${var.name}-${random_string.name.result}"
  resource_group_name    = var.resource_group_name
  administrator_login    = random_string.name.result
  administrator_password = random_password.password.result
  backup_retention_days  = 7
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.default.id
  sku_name               = var.sku
  version                = var.mysql_version

  high_availability {
    mode = var.high_availablity
  }

  maintenance_window {
    day_of_week  = var.maintenance_window.day_of_week
    start_hour   = var.maintenance_window.start_hour
    start_minute = var.maintenance_window.start_minute
  }

  storage {
    auto_grow_enabled  = var.storage.auto_grow_enabled != null ? var.storage.auto_grow_enabled : true
    io_scaling_enabled = var.storage.io_scaling_enabled != null ? var.storage.io_scaling_enabled : false
    size_gb            = var.storage.size_gb != null ? var.storage.size_gb : 20
    iops               = var.storage.iops != null ? var.storage.iops : 360
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}

# Manages the MySQL Flexible Server Database
resource "azurerm_mysql_flexible_database" "main" {
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
  name                = "mysqlfsdb-${var.name}-${random_string.name.result}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.default.name
}
