
module "avd_core_rule_collection_group" {
  source = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  # source             = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  firewall_policy_rule_collection_group_firewall_policy_id = module.firewall_policy.resource.id
  firewall_policy_rule_collection_group_name               = "NetworkRuleCollectionGroup"
  firewall_policy_rule_collection_group_priority           = 1000
  firewall_policy_rule_collection_group_network_rule_collection = [{
    action   = "Allow"
    name     = "AVDCoreNetworkRules"
    priority = 400
    rule = [
      {
        name              = "Login to Microsoft"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["login.microsoftonline.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name                  = "AVD"
        source_addresses      = ["10.100.0.0/24"]
        destination_addresses = ["WindowsVirtualDesktop", "AzureFrontDoor.Frontend", "AzureMonitor"]
        protocols             = ["TCP"]
        destination_ports     = ["443"]
      },
      {
        name              = "GCS"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["gcs.prod.monitoring.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name                  = "DNS"
        source_addresses      = ["10.100.0.0/24"]
        destination_addresses = ["AzureDNS"]
        protocols             = ["TCP", "UDP"]
        destination_ports     = ["53"]
      },
      {
        name              = "azkms"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["azkms.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["1688"]
      },
      {
        name              = "KMS"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["kms.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["1688"]
      },
      {
        name              = "mrglobalblob"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["mrsglobalsteus2prod.blob.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "wvdportalstorageblob"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["wvdportalstorageblob.blob.core.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "oneocsp"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["oneocsp.microsoft.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "microsoft.com"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["www.microsoft.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
    ]
    }
  ]
}


module "avd_optional_rule_collection_group" {
  source = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  # source             = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  firewall_policy_rule_collection_group_firewall_policy_id = module.firewall_policy.resource.id
  firewall_policy_rule_collection_group_name               = "AVDOptionalRuleCollectionGroup"
  firewall_policy_rule_collection_group_priority           = 1050
  firewall_policy_rule_collection_group_network_rule_collection = [{
    action   = "Allow"
    name     = "AVDOptionalNetworkRules"
    priority = 500
    rule = [
      {
        name              = "time"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["time.windows.com"]
        protocols         = ["UDP"]
        destination_ports = ["123"]
      },
      {
        name              = "login windows.net"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["login.windows.net"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
      {
        name              = "msftconnecttest"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["www.msftconnecttest.com"]
        protocols         = ["TCP"]
        destination_ports = ["443"]
      },
    ]
    }
  ]

  firewall_policy_rule_collection_group_application_rule_collection = [{
    action   = "Allow"
    name     = "AVDOptionalApplicationRules"
    priority = 600
    rule = [
      {
        name                  = "Windows"
        source_addresses      = ["10.100.0.0/24"]
        destination_fqdn_tags = ["WindowsUpdate", "WindowsDiagnostics", "MicrosoftActiveProtectionService"]
        protocols = [
          {
            port = 443
            type = "Https"
          }
        ]
      },
      {
        name              = "Events"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["*.events.data.microsoft.com"]
        protocols = [
          {
            port = 443
            type = "Https"
          }
        ]
      },
      {
        name              = "sfx"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["*.sfx.ms"]
        protocols = [
          {
            port = 443
            type = "Https"
          }
        ]
      },
      {
        name              = "digicert"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["*.digicert.com"]
        protocols = [
          {
            port = 443
            type = "Https"
          }
        ]
      },
      {
        name              = "Azure DNS"
        source_addresses  = ["10.100.0.0/24"]
        destination_fqdns = ["*.azure-dns.com", "*.azure-dns.net"]
        protocols = [
          {
            port = 443
            type = "Https"
          }
        ]
      },
    ]
    }
  ]
}

module "m365rulecollectiongroup" {
  source = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  # source             = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  firewall_policy_rule_collection_group_firewall_policy_id = module.firewall_policy.resource.id
  firewall_policy_rule_collection_group_name               = "M365RuleCollectionGroup"
  firewall_policy_rule_collection_group_priority           = 2000
  firewall_policy_rule_collection_group_network_rule_collection = [{
    action   = "Allow"
    name     = "M365NetworkRules"
    priority = 600
    rule = [
      {
        name                  = "M365"
        source_addresses      = ["10.100.0.0/24"]
        destination_addresses = ["Office365.Common.Allow.Required"]
        protocols             = ["TCP"]
        destination_ports     = ["443", "80"]
      }
    ]
    }
  ]
}

module "internetrulecollectiongroup" {
  source = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  # source             = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  firewall_policy_rule_collection_group_firewall_policy_id = module.firewall_policy.resource.id
  firewall_policy_rule_collection_group_name               = "InternetRuleCollectionGroup"
  firewall_policy_rule_collection_group_priority           = 3000
  firewall_policy_rule_collection_group_network_rule_collection = [{
    action   = "Allow"
    name     = "InternetNetworkRules"
    priority = 800
    rule = [
      {
        name                  = "Internet"
        source_addresses      = ["10.0.0.0/24"]
        destination_addresses = ["*"]
        protocols             = ["TCP"]
        destination_ports     = ["443", "80"]
      }
    ]
    }
  ]
}

