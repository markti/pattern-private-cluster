output "workload_identity_client_id" {
  description = "The client ID of the User Assigned Managed Identity for Workload Identity."
  value       = azurerm_user_assigned_identity.workload_identity.client_id
}
output "workload_identity_principal_id" {
  description = "The principal ID of the User Assigned Managed Identity for Workload Identity."
  value       = azurerm_user_assigned_identity.workload_identity.principal_id
}
output "workload_namespace" {
  description = "The namespace of the workload using Workload Identity."
  value       = var.workload_namespace
}
output "workload_service_account" {
  description = "The service account name of the workload using Workload Identity."
  value       = var.workload_service_account
}
