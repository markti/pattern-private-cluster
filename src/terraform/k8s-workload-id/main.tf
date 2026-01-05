resource "kubernetes_namespace" "workload_identity" {
  metadata {
    name = var.workload_namespace
  }
}

resource "kubernetes_service_account" "workload_identity" {
  metadata {
    name      = var.workload_service_account
    namespace = kubernetes_namespace.workload.metadata[0].name
    annotations = {
      "azure.workload.identity/client-id" = var.workload_identity_client_id
    }
  }
}
