terraform {
  required_version = ">= 1.0"
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.52.0"
    }
  }
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "boundary-demo-init"
    }
  }
}

provider "hcp" {}
