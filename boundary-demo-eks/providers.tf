terraform {
  required_providers {
    aws = {
      version = "< 5.0.0"
      source  = "hashicorp/aws"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.52.0"
    }
    kubernetes = {
      version = ">= 2.0.0"
      source  = "hashicorp/kubernetes"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = "~>1.1.0"
    }
    okta = {
      source  = "okta/okta"
      version = "~> 3.40"
    }
    tfe = {
      version = "~> 0.42.0"
    }
    vault = {
      version = "~> 3.14.0"
    }
  }
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "boundary-demo"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "tfe" {}

provider "boundary" {
  addr                   = data.tfe_outputs.boundary_demo_init.values.boundary_url
  auth_method_id         = data.tfe_outputs.boundary_demo_init.values.boundary_admin_auth_method
  auth_method_login_name = var.boundary_user
  auth_method_password   = var.boundary_password
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.zts.token
}

provider "okta" {
  org_name = var.okta_org_name
  base_url = var.okta_baseurl
}

provider "vault" {
  address   = data.tfe_outputs.boundary_demo_init.values.vault_pub_url
  token     = data.tfe_outputs.boundary_demo_init.values.vault_token
  namespace = "admin"
}

provider "hcp" {}
