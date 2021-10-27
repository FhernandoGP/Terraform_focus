terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
 
    }
    kubernetes = {
      source = "hashicorp/kubernetes"

    }
    helm = {
      source  = "hashicorp/helm"

    }
  }
}



provider "digitalocean" {
  token = "c7f61ffe9b3b47f3366fa4bbc7859dd79b7e1001dc413bfebb03101525de414e"
}


resource "digitalocean_kubernetes_cluster" "focustest_cluster" {
  name    = "focustest"
  region  = "nyc1"
  version = "1.21.5-do.0"

  node_pool {
    name       = "focusnode"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}

resource "local_file" "kubernetes_config"{
	content="${digitalocean_kubernetes_cluster.focustest_cluster.kube_config.0.raw_config}"
	filename="kubeconfig.yaml"

}



