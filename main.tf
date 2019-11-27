# --------------------------------------------------------------------------
# main file which generate the module content
#i
# Author: valery.jacot@innosmart.io
# --------------------------------------------------------------------------
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = ">=1.36.0"
}
# Generate the local variable as a map which will encapsulate all the key values for the tags
locals {
  common_tags = map(
    "owner", var.owner,
    "costcenter", var.costcenter,
    "customer", var.customer,
    "project", var.project,
    "applicationid", var.applicationid,
    "template", var.template,
    "template_version", var.template_version,
    "environment", var.environment,
    "updatedate", timestamp(),
    "tier", var.tier,
    "cron", var.cron,
    "automation", var.automation,
    "confidentiality", var.confidentiality,
    "compliance", var.compliance
  )
}
