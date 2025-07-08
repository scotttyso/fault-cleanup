terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.16.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aci" {
  insecure = true
  password = var.apic_password
  url      = "https://${var.apic_hostname}"
  username = var.apic_username
}

variable "apic_hostname" {
  default     = "apic.example.com"
  description = "Hostname or IP address of the APIC."
  type        = string
}
variable "apic_password" {
  default     = "dummydummy"
  description = "Password for User based Authentication."
  sensitive   = true
  type        = string
}
variable "apic_username" {
  default     = "admin"
  description = "Username for User based Authentication."
  type        = string
}

resource "aci_rest_managed" "disable_atomic_counters" {
  dn         = "uni/fabric/ogmode"
  class_name = "dbgOngoingAcMode"
  content = {
    adminSt = "disabled"
    mode    = "path"
  }
}

locals {
    disable_ingress_drop_counters = [
        "uni/infra/moninfra-default/tarinfra-l1PhysIf/stat-eqptIngrDropPkts/coll-5min/thrDouble-eqptIngrDropPktsForwardingRate",
        "uni/infra/moninfra-default/tarinfra-pcAggrIf/stat-eqptIngrDropPkts/coll-5min/thrDouble-eqptIngrDropPktsForwardingRate",
        "uni/fabric/monfab-default/tarfab-l1PhysIf/stat-eqptIngrDropPkts/coll-5min/thrDouble-eqptIngrDropPktsForwardingRate",
        "uni/tn-common/monepg-default/tarepg-l3extOut/stat-l2IngrBytesAg/coll-15min/thrDouble-l2IngrBytesAgDropRate",
        "uni/tn-common/monepg-default/tarepg-sviIf/stat-l2IngrPkts/coll-5min/thrDouble-l2IngrPktsDropRate",
        "uni/tn-common/monepg-default/tarepg-vlanCktEp/stat-l2IngrPkts/coll-5min/thrDouble-l2IngrPktsDropRate"
    ]
}

# resource "aci_rest_managed" "disable_ingress_drop_counters" {
#   for_each = toset(local.disable_ingress_drop_counters)
#   dn         = each.key
#   class_name = "statsThrDoubleP"
#   content = {
#     highSevState = "Crit,Major,Minor"
#   }
# }
