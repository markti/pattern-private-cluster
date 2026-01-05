resource "kubernetes_manifest" "nap_node_class" {
  manifest = {
    apiVersion = "karpenter.azure.com/v1beta1"
    kind       = "AKSNodeClass"
    metadata   = { name = "default" }
    spec = {
      imageFamily  = "Ubuntu2204"
      osDiskSizeGB = 128
      # You can also set vnetSubnetID here if you want NAP nodes in a specific subnet remembering from docs :contentReference[oaicite:9]{index=9}
      # vnetSubnetID = azurerm_subnet.aks.id
    }
  }
}

resource "kubernetes_manifest" "nap_node_pool" {
  depends_on = [kubernetes_manifest.nap_node_class]

  manifest = {
    apiVersion = "karpenter.sh/v1beta1"
    kind       = "NodePool"
    metadata   = { name = "general" }
    spec = {
      template = {
        spec = {
          nodeClassRef = {
            name = "default"
          }
          # Example constraints:
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = ["amd64"]
            }
          ]
        }
      }

      # IMPORTANT: NAP disable requires CPU limits set to 0; limits also act as a safety rail. :contentReference[oaicite:10]{index=10}
      limits = { cpu = "200" }
    }
  }
}
