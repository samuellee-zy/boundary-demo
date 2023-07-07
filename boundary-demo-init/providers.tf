terraform {
  required_version = ">= 1.0"
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.63.0"
    }
  }
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "boundary-demo-init"
    }
  }
}

provider "hcp" {
  project_id = "eff70472-d252-4d87-b64f-2a829c2ae5df"
}
