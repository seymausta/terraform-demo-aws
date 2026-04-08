resource "kubernetes_deployment" "this" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.this.metadata[0].name
    labels    = var.labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = var.labels
    }

    template {
      metadata {
        labels = var.labels
      }

      spec {
        container {
          name  = var.app_name
          image = var.container_image

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}