provider "azurerm" {
  features {
    log_analytics_workspace {
      permanetly_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false // Set to True for Production
    }
    virtual_machine {
      delete_os_disk_on_termination  = true
      skip_shutdown_and_force_delete = true
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

module "vnet" {
  source      = "./Modules/vnet"
  location    = var.location
  environment = var.environment
  tags        = var.tags
}
/*module "vm" {
  source                 = "./Modules/vm"
  location               = var.location
  environment            = var.environment
  tags                   = var.tags
  subnet_id              = module.vnet.subnet_id
  disk_encryption_set_id = module.dse.dse_id
}*/
module "law" {
  source      = "./Modules/law"
  location    = var.location
  environment = var.environment
  tags        = var.tags
  prefix      = var.prefix
}

module "dse" {
  source      = "./Modules/dse"
  location    = var.location
  environment = var.environment
  tags        = var.tags
  prefix      = var.prefix
}

module "avd" {
  source      = "./Modules/avd"
  location    = var.location
  environment = var.environment
  tags        = var.tags
  prefix      = var.prefix
  subnet_id   = module.vnet.subnet_id
  law_id      = module.law.law_id
  law_key     = module.law.law_key
  dse_id      = module.dse.dse_id
}