variable "subscription_id" { type = string }
variable "tenant_id" { type = string }

variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "environment must be dev, qa, or prod."
  }
}

variable "location" { type = string, default = "eastus" }
variable "tags" { type = map(string), default = {} }

variable "resource_group" {
  type = object({ name = string, tags = map(string) })
}

variable "network" {
  type = object({
    vnet_name          = string
    address_space      = list(string)
    dns_servers        = optional(list(string), [])
    subnet_prefixes    = map(string)
    subnet_delegations = optional(map(list(string)), {})
    tags               = map(string)
  })
}

variable "log_analytics" {
  type = object({
    name              = string
    sku               = optional(string, "PerGB2018")
    retention_in_days = optional(number, 30)
    tags              = map(string)
  })
}

variable "storage" {
  type = object({
    name                          = string
    account_tier                  = optional(string, "Standard")
    account_replication_type      = optional(string, "LRS")
    min_tls_version               = optional(string, "TLS1_2")
    access_tier                   = optional(string, "Hot")
    kind                          = optional(string, "StorageV2")
    public_network_access_enabled = optional(bool, false)
    tags                          = map(string)
  })
}

variable "key_vault" {
  type = object({
    name                          = string
    sku_name                      = optional(string, "standard")
    purge_protection_enabled      = optional(bool, true)
    soft_delete_retention_days    = optional(number, 90)
    public_network_access_enabled = optional(bool, false)
    tags                          = map(string)
  })
}

variable "sql" {
  type = object({
    server_name                   = string
    database_name                 = string
    administrator_login           = string
    administrator_password        = string
    version                       = optional(string, "12.0")
    sku_name                      = optional(string, "GP_S_Gen5_2")
    max_size_gb                   = optional(number, 32)
    zone_redundant                = optional(bool, false)
    public_network_access_enabled = optional(bool, false)
    minimum_tls_version           = optional(string, "1.2")
    tags                          = map(string)
  })
}

variable "aks" {
  type = object({
    name               = string
    dns_prefix         = string
    kubernetes_version = optional(string, "1.29.0")
    node_pool_name     = optional(string, "system")
    node_count         = optional(number, 2)
    vm_size            = optional(string, "Standard_DS2_v2")
    os_disk_size_gb    = optional(number, 80)
    identity_type      = optional(string, "SystemAssigned")
    admin_username     = optional(string, "azureuser")
    ssh_public_key     = string
    network_plugin     = optional(string, "azure")
    load_balancer_sku  = optional(string, "standard")
    service_cidr       = optional(string, "10.2.0.0/16")
    dns_service_ip     = optional(string, "10.2.0.10")
    docker_bridge_cidr = optional(string, "172.17.0.1/16")
    tags               = map(string)
  })
}
