output "azurerm_mysql_flexible_server" {
  value       = azurerm_mysql_flexible_server.default.name
  description = "The name of the MySQL Flexible Server."
}

output "admin_login" {
  value       = azurerm_mysql_flexible_server.default.administrator_login
  description = "The admin username for the MySQL server."
}

output "admin_password" {
  sensitive   = true
  value       = azurerm_mysql_flexible_server.default.administrator_password
  description = "The admin password for the MySQL server."
}

output "mysql_flexible_server_database_name" {
  value       = azurerm_mysql_flexible_database.main.name
  description = "The name of the MySQL Flexible Server Database."
}
