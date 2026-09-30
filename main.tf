module "resource_group" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/resource-group?ref=v1.0.0"
  name = var.resource_group.name
  location = var.location
  tags = local.resource_group_tags
}

module "network" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/network?ref=v1.0.0"
  name = var.network.vnet_name
  location = var.location
  resource_group_name = module.resource_group.name
  address_space = var.network.address_space
  dns_servers = var.network.dns_servers
  subnet_prefixes = var.network.subnet_prefixes
  subnet_delegations = var.network.subnet_delegations
  tags = local.network_tags
}

module "log_analytics" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/log-analytics?ref=v1.0.0"
  name = var.log_analytics.name
  location = var.location
  resource_group_name = module.resource_group.name
  sku = var.log_analytics.sku
  retention_in_days = var.log_analytics.retention_in_days
  tags = local.log_analytics_tags
}

module "storage" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/storage-account?ref=v1.0.0"
  name = var.storage.name
  location = var.location
  resource_group_name = module.resource_group.name
  account_tier = var.storage.account_tier
  account_replication_type = var.storage.account_replication_type
  min_tls_version = var.storage.min_tls_version
  access_tier = var.storage.access_tier
  kind = var.storage.kind
  public_network_access_enabled = var.storage.public_network_access_enabled
  tags = local.storage_tags
}

module "key_vault" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/key-vault?ref=v1.0.0"
  name = var.key_vault.name
  location = var.location
  resource_group_name = module.resource_group.name
  sku_name = var.key_vault.sku_name
  tenant_id = var.tenant_id
  purge_protection_enabled = var.key_vault.purge_protection_enabled
  soft_delete_retention_days = var.key_vault.soft_delete_retention_days
  public_network_access_enabled = var.key_vault.public_network_access_enabled
  tags = local.key_vault_tags
}

module "sql" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/sql-server?ref=v1.0.0"
  name = var.sql.server_name
  database_name = var.sql.database_name
  resource_group_name = module.resource_group.name
  location = var.location
  administrator_login = var.sql.administrator_login
  administrator_password = var.sql.administrator_password
  version = var.sql.version
  sku_name = var.sql.sku_name
  max_size_gb = var.sql.max_size_gb
  zone_redundant = var.sql.zone_redundant
  public_network_access_enabled = var.sql.public_network_access_enabled
  minimum_tls_version = var.sql.minimum_tls_version
  tags = local.sql_tags
}

module "aks" {
  source = "git::https://github.com/kishorawake/modulerepo.git//modules/aks_cluster?ref=v1.0.0"
  name = var.aks.name
  location = var.location
  resource_group_name = module.resource_group.name
  dns_prefix = var.aks.dns_prefix
  kubernetes_version = var.aks.kubernetes_version
  node_pool_name = var.aks.node_pool_name
  node_count = var.aks.node_count
  vm_size = var.aks.vm_size
  os_disk_size_gb = var.aks.os_disk_size_gb
  identity_type = var.aks.identity_type
  admin_username = var.aks.admin_username
  ssh_public_key = var.aks.ssh_public_key
  network_plugin = var.aks.network_plugin
  load_balancer_sku = var.aks.load_balancer_sku
  service_cidr = var.aks.service_cidr
  dns_service_ip = var.aks.dns_service_ip
  docker_bridge_cidr = var.aks.docker_bridge_cidr
  tags = local.aks_tags
}
