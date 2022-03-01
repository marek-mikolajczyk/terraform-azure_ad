terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
#      version = "~> 2.0.0"
    }
  }

# backend "local" {}

  cloud {
    organization = "example-org-e95f05"
    workspaces {
      name = "terraform-azure_ad"
    }
  }

  required_version = ">= 0.13, <= 2.0"

}
provider "azuread" {
}
