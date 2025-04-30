<!-- BEGIN_TF_DOCS -->
# Azurerm Shared Image Gallery Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/cloudastro/virtual-network/azurerm/latest)

This module is designed to manage an Azure Shared Image Gallery, including the creation and management of shared images, image versions, and the configuration of image sharing settings. The Shared Image Gallery allows you to manage VM image versions, replication across regions, and sharing with multiple subscriptions or tenants.

## Features
- **Shared Image Gallery Management**: Facilitates the creation and management of an Azure Shared Image Gallery.
- **Image Definitions & Versions**: Supports the creation of image definitions and multiple versions within the gallery.
- **Image Sharing**: Allows configuration for sharing images across subscriptions or tenants, including as a community gallery.

## Example Usage
This example demonstrates how to use the `azurerm_shared_image_gallery` module to create a shared image gallery with image definitions and versions, and configure it for sharing.
```
resource "azurerm_resource_group" "gallery_rg" {
  location = "rg-vnet-example"
  name     = "germanywestcentral"
}

module "shared_image_gallery" {
  source              = "../tf-modules/tf-azurerm-shared-image-gallery"
  name                = "image-gallery-name"
  resource_group_name = azurerm_resource_group.gallery_rg.name
  location            = "germanywestcentral"
  tags                = "tags"
  description         = "Storage of hardenened base images"

  shared_images_definitions = {
    redhat = {
      trusted_launch_enabled = true
      hyper_v_generation     = "V2"
      os_type     = "Linux"
      description = "RedHat RHEL"
      name        = "redhat-enterprise-linux-94-gen2-img-def"
      identifier = {
        offer     = "RHEL"
        publisher = "RedHat"
        sku       = "94_gen2"
      }
    },
    windows = {
      trusted_launch_enabled = true
      hyper_v_generation     = "V2"
      os_type     = "Windows"
      description = "Windows Datacenter smalldisk g2 custom image."
      name        = "windows-datacenter-2022-smalldsk-g2-img-def"
      identifier = {
        offer     = "CustomWindowsServer"
        publisher = "Companyname"
        sku       = "2022-datacenter-core-smalldisk-g2"
      }
    }
  }
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_shared_image.shared_image](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) | resource |
| [azurerm_shared_image_gallery.shared_image_gallery](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery) | resource |

<!-- markdownlint-disable MD013 -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | * `description` - (Optional) A description for this Shared Image Gallery.<br><br>  Example Input:<pre>description = "An example shared image gallery"</pre> | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | * `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.<br><br>  Example Input:<pre>location = "eastus"</pre> | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | * `name` - (Required) Specifies the name of the Shared Image Gallery. Changing this forces a new resource to be created.<br><br>  Example Input:<pre>name = "my-shared-image-gallery"</pre> | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | * `resource_group_name` - (Required) The name of the resource group in which to create the Shared Image Gallery. Changing this forces a new resource to be created.<br><br>  Example Input:<pre>resource_group_name = "my-resource-group"</pre> | `string` | n/a | yes |
| <a name="input_shared_images_definitions"></a> [shared\_images\_definitions](#input\_shared\_images\_definitions) | * `shared_images_definitions` - (Required) Manages a Shared Image within a Shared Image Gallery.<br>    * `name` - (Required) Specifies the name of the Shared Image. Changing this forces a new resource to be created.<br>    * `identifier` - (Required) An `identifier` block as defined below.<br>      * `offer` - (Required) The Offer Name for this Shared Image. Changing this forces a new resource to be created.<br>      * `publisher` - (Required) The Publisher Name for this Gallery Image. Changing this forces a new resource to be created.<br>      * `sku` - (Required) The Name of the SKU for this Gallery Image. Changing this forces a new resource to be created.<br>    * `os_type` - (Required) The type of Operating System present in this Shared Image. Possible values are `Linux` and `Windows`. Changing this forces a new resource to be created.<br>    * `purchase_plan` - (Optional) A `purchase_plan` block as defined below.<br>      * `name` - (Required) The Purchase Plan Name for this Shared Image. Changing this forces a new resource to be created.<br>      * `publisher` - (Optional) The Purchase Plan Publisher for this Gallery Image. Changing this forces a new resource to be created.<br>      * `product` - (Optional) The Purchase Plan Product for this Gallery Image. Changing this forces a new resource to be created.<br>    * `description` - (Optional) A description of this Shared Image.<br>    * `disk_types_not_allowed` - (Optional) One or more Disk Types not allowed for the Image. Possible values include `Standard_LRS` and `Premium_LRS`.<br>    * `end_of_life_date` - (Optional) The end of life date in RFC3339 format of the Image.<br>    * `eula` - (Optional) The End User Licence Agreement for the Shared Image. Changing this forces a new resource to be created.<br>    * `specialized` - (Optional) Specifies that the Operating System used inside this Image has not been Generalized (for example, `sysprep` on Windows has not been run). Changing this forces a new resource to be created.<br>    ~> **Note:** It's recommended to Generalize images where possible - Specialized Images reuse the same UUID internally within each Virtual Machine, which can have unintended side-effects.<br>    * `architecture` - (Optional) CPU architecture supported by an OS. Possible values are `x64` and `Arm64`. Defaults to `x64`. Changing this forces a new resource to be created.<br>    * `hyper_v_generation` - (Optional) The generation of HyperV that the Virtual Machine used to create the Shared Image is based on. Possible values are `V1` and `V2`. Defaults to `V1`. Changing this forces a new resource to be created.<br>    * `max_recommended_vcpu_count` - (Optional) Maximum count of vCPUs recommended for the Image.<br>    * `min_recommended_vcpu_count` - (Optional) Minimum count of vCPUs recommended for the Image.<br>    * `max_recommended_memory_in_gb` - (Optional) Maximum memory in GB recommended for the Image.<br>    * `min_recommended_memory_in_gb` - (Optional) Minimum memory in GB recommended for the Image.<br>    * `privacy_statement_uri` - (Optional) The URI containing the Privacy Statement associated with this Shared Image. Changing this forces a new resource to be created.<br>    * `release_note_uri` - (Optional) The URI containing the Release Notes associated with this Shared Image.<br>    * `trusted_launch_supported` - (Optional) Specifies if supports creation of both Trusted Launch virtual machines and Gen2 virtual machines with standard security created from the Shared Image. Changing this forces a new resource to be created.<br>    * `trusted_launch_enabled` - (Optional) Specifies if Trusted Launch has to be enabled for the Virtual Machine created from the Shared Image. Changing this forces a new resource to be created.<br>    * `confidential_vm_supported` - (Optional) Specifies if supports creation of both Confidential virtual machines and Gen2 virtual machines with standard security from a compatible Gen2 OS disk VHD or Gen2 Managed image. Changing this forces a new resource to be created.<br>    * `confidential_vm_enabled` - (Optional) Specifies if Confidential Virtual Machines enabled. It will enable all the features of trusted, with higher confidentiality features for isolate machines or encrypted data. Available for Gen2 machines. Changing this forces a new resource to be created.<br>    ~> **Note:**: Only one of `trusted_launch_supported`, `trusted_launch_enabled`, `confidential_vm_supported` and `confidential_vm_enabled` can be specified.<br>    * `accelerated_network_support_enabled` - (Optional) Specifies if the Shared Image supports Accelerated Network. Changing this forces a new resource to be created.<br>    * `hibernation_enabled` - (Optional) Specifies if the Shared Image supports hibernation. Changing this forces a new resource to be created.<br>    * `disk_controller_type_nvme_enabled` - (Optional) Specifies if the Shared Image supports NVMe disks. Changing this forces a new resource to be created.<br>    * `tags` - (Optional) A mapping of tags to assign to the Shared Image.<br><br>  Example Input:<pre>shared_images_definitions = {<br>    WindowsServer = {<br>      name = "WindowsServer-2022-hardened"<br>      identifier = {<br>        publisher = "companyname"<br>        offer     = "WindowsServer-2022-hardened"<br>        sku       = "2022-datacenter-g2"<br>        version   = "0.1.0"<br>      }<br>      os_type     = "Windows"<br>      description = "Windows server 2022 Custom image"<br>    }<br>  ]</pre> | <pre>map(object({<br>    name = string<br>    identifier = object({<br>      offer     = string<br>      publisher = string<br>      sku       = string<br>    })<br>    purchase_plan = optional(object({<br>      name      = string<br>      publisher = optional(string)<br>      product   = optional(string)<br>    }))<br>    os_type                             = string<br>    description                         = optional(string)<br>    disk_types_not_allowed              = optional(list(string))<br>    end_of_life_date                    = optional(string)<br>    eula                                = optional(string)<br>    specialized                         = optional(string)<br>    architecture                        = optional(string, "x64")<br>    hyper_v_generation                  = optional(string, "V1")<br>    max_recommended_vcpu_count          = optional(number)<br>    min_recommended_vcpu_count          = optional(number)<br>    max_recommended_memory_in_gb        = optional(number)<br>    min_recommended_memory_in_gb        = optional(number)<br>    privacy_statement_uri               = optional(string)<br>    release_note_uri                    = optional(string)<br>    trusted_launch_enabled              = optional(bool)<br>    trusted_launch_supported            = optional(bool)<br>    confidential_vm_supported           = optional(bool)<br>    confidential_vm_enabled             = optional(bool)<br>    accelerated_network_support_enabled = optional(bool)<br>    hibernation_enabled                 = optional(string)<br>    disk_controller_type_nvme_enabled   = optional(string)<br>    tags                                = optional(map(string))<br>  }))</pre> | `null` | no |
| <a name="input_sharing"></a> [sharing](#input\_sharing) | * `sharing` - (Optional) A `sharing` block as defined below. Changing this forces a new resource to be created.<br>    * `permission` - (Required) The permission of the Shared Image Gallery when sharing. Possible values are `Community`, `Groups` and `Private`. Changing this forces a new resource to be created.<br>    ~> **Note:** This requires that the Preview Feature `Microsoft.Compute/CommunityGalleries` is enabled, see [the documentation](https://learn.microsoft.com/azure/virtual-machines/share-gallery-community?tabs=cli) for more information.<br>    * `community_gallery` - (Optional) A `community_gallery` block as defined below. Changing this forces a new resource to be created.<br>    ~> **NOTE:** `community_gallery` must be set when `permission` is set to `Community`.<br>      * `eula` - (Required) The End User Licence Agreement for the Shared Image Gallery. Changing this forces a new resource to be created.<br>      * `prefix` - (Required) Prefix of the community public name for the Shared Image Gallery. Changing this forces a new resource to be created.<br>      * `publisher_email` - (Required) Email of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.<br>      * `publisher_uri` - (Required) URI of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.<br><br>  Example Input:<pre># private gallery<br>  sharing = {<br>    permission = "Private"<br>  }<br><br>  #community gallery<br>  sharing = {<br>    permission = "Community"<br>    community_gallery = {<br>      eula            = "Accept"<br>    <br>      publisher_email = "email@example.com"<br>      publisher_uri   = "www.example.com"<br>    }<br><br>  }</pre> | <pre>optional(object({<br>    permission = string<br>    community_gallery = optional(object({<br>      eula            = string<br>      prefix          = string<br>      publisher_email = string<br>      publisher_uri   = string<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | * `tags` - (Optional) A mapping of tags to assign to the Shared Image Gallery.<br><br>  Example Input:<pre>tags = {<br>    "environment" = "production"<br>    "department"  = "IT"<br>  }</pre> | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource"></a> [resource](#output\_resource) | Azure Shared Image Gallery output object |
| <a name="output_shared_images_definitions_resource"></a> [shared\_images\_definitions\_resource](#output\_shared\_images\_definitions\_resource) | Azure Shared Images definitions |

## Modules

No modules.

## Additional Information
For more details on the Azure Shared Image Gallery and its capabilities, refer to the [Azure documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/shared-image-galleries). This module is intended to be flexible and can be customized to fit various use cases, including multi-region replication and sharing across different Azure tenants.

## Resources
- [AzureRM Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Shared Image Gallery](https://learn.microsoft.com/en-us/azure/virtual-machines/shared-image-galleries)

## Notes
- Ensure that your subscription has the necessary permissions to create and manage Shared Image Galleries.
- Review the Azure naming conventions and constraints to avoid issues with resource names.
- Always validate your Terraform configuration before deployment to catch potential issues early.

## License
This module is licensed under the Apache V2 License. See the [LICENSE](./LICENSE) file for more details.
<!-- END_TF_DOCS -->