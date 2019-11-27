# terraform-azurerm-common-tags
This Terraform modules allow you to define a standard way to name and manage your tags across all the resources managed by your template. It also suggest a standard way to define your tag convention across all your organization.

# Tag compliance

## Why should you use tags within your organization

Tagging resrouces creates several opportunities. It definitively helps in cost management - you can create personal dashboards to evaluate the costs of resources used for an application, a deployment, a customer or what ever and this across multiple deployment, multiple environments and also multiple regions.

You may also use tags for automation and security management. You may also define in which tier the resources are supported; there are a lot of opportunities to use tags.

## Tags included in this template

### Business tags

- **owner**: It allows you to identify who is responsible of this resource. Suggestion: Use an email address of a group such as project team, service team or department who will be the owners. This approach will allow you to contact directly several people who should know about the resource in case of issue. In development, you may also ask your developers to use directly their own address.

- **costcenter**: This tag allows you to consolidate your organization billing to potentially cross-charge to the correct department using directly his cost center.

- **customer**: If your running infrastructure for customers, you will be able to differentiate which infrastructure belongs to which customer using this tag.

- **project**: The project which the resources are supporting.

### Technical tags

- **applicationid**: Allow you to regroup the resources of same application

- **template**: Name of the repository / Terraform template which is responsible of the lifecycle of the resources

- **version**: Version of your template / environment. Needs to be inline with your source code repository versionning; this will allow you to find back the versions of the template used to provision the resources

- **environment**: Will give you the opportunity to define which environment the resources belongs to. In general you have *dev*, *stg*, *prod*

- **updatedate**: Define the date of the last modification of the resource (or said differently, the last time the automation has been run for this resource)

- **tier**: Used for the support; please use your standards to define in which tiers the resources may fall in

Tags directly dependant of the resource - those tags are not in the template but you may consider adding them in your templates:

- **name**: Name of the resource - this allows you to differentiate the technical name you may define in your governance to name the resources within Azure and the name you have in the tags which may be more business focused

### Automation tags

You may consider using tags to search specific resources and shutdown them or destroy them after a certain amount of time. How would you do this?

- **cron**: Use this tag to define when the resource should be included in an automated activity - suggestion: use the cron notation for this.

- **automation**: Use this tag to define which kind of activity needs to be done. Suggestion: Use a json format to say when youhld be perform what - think about starting and stoping the VM, you can define when, which activity should be done.

### Security tags

- **confidentiality**: Use your standard to define the level of confidentiality of the data handled by the resources

- **compliance**: List of the compliance requirements which needs to be assumed by the resources (ex. GDPR, SOC2, etc.)

## Azure limitation

Please be aware that Azure limits the number of tags per resources and the length of the tag names and values. [More information available here.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)

# How to use this module

You can reference the module in your templates using this code:

```hcl
module "std_tags" {
    src             = "github.com/Innosmart-io/terraform-azurerm-common-tags"
    owner           = "${var.owner}"
    costcenter      = "${var.costcenter}"
    customer        = "${var.customer}"
    project         = "${var.project}"
    applicationid   = "${var.applicationid}"
    template        = "${var.template}"
    template_version= "${var.template_version}"
    environment     = "${var.environment}"
    tier            = "${var.tier}"
    cron            = "${var.cron}"
    automation      = "${var.automation}"
    confidentiality = "${var.confidentiality}"
    compliance      = "${var.compliance}"
}

# Then, you can reference it in the resources or other modules by:

# If you do not need to add tags, then follow this approach:
resource "azurerm_resource_group" "rg1" {
  name      = "rg-1"
  location  = "${var.region}"

  tags      = "${module.std_tags.common_tags}"
}

# If you want to add tags, then follow this approach:
resource "azurerm_resource_group" "rg1" {
  name      = "rg-1"
  location  = "${var.region}"

  tags      = "${merge(
    map (
      "name", var.rg_name
    ), 
    module.std_tags.common_tags)}"
}

```

# Authors
Originally created by [Valery Jacot](https://github.com/valeryinno)

# License
[MIT](https://github.com/valeryinno/terraform-azurerm-vm/blob/master/LICENSE)