output "resource_group_name" {
  description = "The name of the resource group where the AKS cluster is deployed."
  value       = var.resource_group_name
}
output "aks_cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.name
}
