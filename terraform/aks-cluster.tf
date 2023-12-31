//resource "random_pet" "prefix" {}

provider "azurerm" {
  features {
  }

  client_id = "2685d5c7-d3dc-4393-bc3c-2fc56fc19067"
  client_secret = "Rwq8Q~dvNS6Ve5IDJfTc44z0Y0QbPl0L3W~tDdjn"
  skip_provider_registration = true
}

data "azurerm_resource_group" "default" {
  name     = "BU-MT"
  //location = "West Europe"
}


resource "azurerm_kubernetes_cluster" "default" {
  name                = "sweeping-leopard-aks"
  //location            = azurerm_resource_group.default.location
  //resource_group_name = azurerm_resource_group.default.name
  location            = "West Europe"
  resource_group_name = "BU-MT"
  dns_prefix          = "sweeping-leopard-k8s"
  kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }


  identity {
  type = "UserAssigned"
    identity_ids = [
      "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/BU-MT/providers/Microsoft.ManagedIdentity/userAssignedIdentities/romegioli",
    ]
  }
  
  role_based_access_control_enabled = true

  tags = {
    environment = "Romegioli"
  }
}

