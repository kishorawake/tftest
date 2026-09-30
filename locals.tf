locals {
  default_tags = merge({
    environment = var.environment
    managed_by  = "terraform"
    owner       = "platform-engineering"
  }, var.tags)

  resource_group_tags = merge(local.default_tags, var.resource_group.tags)
  network_tags        = merge(local.default_tags, var.network.tags)
  log_analytics_tags  = merge(local.default_tags, var.log_analytics.tags)
  storage_tags        = merge(local.default_tags, var.storage.tags)
  key_vault_tags      = merge(local.default_tags, var.key_vault.tags)
  sql_tags            = merge(local.default_tags, var.sql.tags)
  aks_tags            = merge(local.default_tags, var.aks.tags)
}
