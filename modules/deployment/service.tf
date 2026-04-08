resource "kubernetes_service" "this" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  spec {
    selector = var.labels


    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = var.service_type
  }

}