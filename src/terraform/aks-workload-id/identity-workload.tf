resource "azurerm_user_assigned_identity" "workload_identity" {
  name                = "id-${var.application_name}-${var.environment_name}-workload"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "workload_identity" {
  name                = "${local.cluster_name}-workload"
  resource_group_name = var.resource_group_name

  parent_id = azurerm_user_assigned_identity.workload_identity.id

  issuer   = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject  = "system:serviceaccount:${var.workload_namespace}:${var.workload_service_account}"
  audience = ["api://AzureADTokenExchange"]
}
