resource "random_pet" "prefix" {}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

/*resource "azurerm_resource_group" "default" {
  name     = "BU-MT"
  location = "westeurope"

  tags = {
    environment = "Demo"
  }
}
*/
resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"
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

/*  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }
*/
  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}
