
terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
}

resource "azurerm_resource_group" "rg_law" {
  name     = "${module.naming.resource_group.name_unique}-workspace"
  location = "eastus2"
}

module "law" {
  source = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "0.3.2"
  location                                  = azurerm_resource_group.this.location
  resource_group_name                       = azurerm_resource_group.this.name
  name                                      = module.naming.log_analytics_workspace.name_unique
  log_analytics_workspace_retention_in_days = 30
  log_analytics_workspace_sku               = "PerGB2018"
  log_analytics_workspace_identity = {
    type = "SystemAssigned"
  }
  monitor_private_link_scope = {
    scope0 = {
      name                  = "law_pl_scope"
      ingestion_access_mode = "PrivateOnly"
      query_access_mode     = "PrivateOnly"
    }
  }
  monitor_private_link_scoped_service_name = "law_pl_service"
  private_endpoints = {
    pe1 = {
      name                          = module.naming.private_endpoint.name_unique
      subnet_resource_id            = module.vnet.subnets["subnet0"].resource.id
      private_dns_zone_resource_ids = [module.privatednszone.resource.id]
      network_interface_name        = "nic-pe-law"
    }
  }
}