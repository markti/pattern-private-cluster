provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = "24a4c592-bfaf-492f-beaf-f10b3b67f03f"
}

variables {
  location = "westus3"
}

run "name" {
  module {
    source = "./testing/prereq-name"
  }
}

run "resource_group" {
  module {
    source = "./testing/prereq-rg"
  }
}

run "vm_size" {
  module {
    source = "./testing/prereq-vm-size"
  }

  variables {
    location      = var.location
    vcpu_min      = 2
    vcpu_max      = 8
    memory_gb_min = 4
    memory_gb_max = 8
    name_filter   = "D"
  }

  providers = {
    azurerm = azurerm
  }

}

# Provision the AKS Cluster
run "provision" {

  command = apply

  module {
    source = "./src/terraform/aks-az-redundant"
  }

  variables {
    resource_group_name = run.resource_group.resource_group_name
    location            = var.location
    application_name    = "tft-${run.name.suffix}"
    environment_name    = "test"
    vm_size             = run.vm_size.candidate_sku
    zones               = ["1", "2", "3"]
  }

  providers = {
    azurerm = azurerm
  }

  assert {
    condition     = length(data.azurerm_kubernetes_cluster.main.name) > 0
    error_message = "Must have a valid AKS Cluster Name"
  }
}

