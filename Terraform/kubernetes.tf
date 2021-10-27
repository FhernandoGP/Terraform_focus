provider "kubernetes"{
config_path = "${local_file.kubernetes_config.filename}"
}


resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
  }
}

provider "helm" {
    service_account = "tiller"
    install_tiller = true
    namespace = "kube-system"
    kubernetes {
      config_path = "${local_file.kubernetes_config.filename}"
      load_config_file = true
    }
}