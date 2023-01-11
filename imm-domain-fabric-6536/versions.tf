terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.20, < 2.0.0"
    }
  }
}
# Need to add "<=2.0.0" to avoid issues with TF API changes