variable "name" {
  type        = string
  description = <<DESCRIPTION
  * `name` - (Required) Specifies the name of the Shared Image Gallery. Changing this forces a new resource to be created.

  Example Input:
  ```
  name = "my-shared-image-gallery"
  ```
  DESCRIPTION
}
variable "resource_group_name" {
  type        = string
  description = <<DESCRIPTION
  * `resource_group_name` - (Required) The name of the resource group in which to create the Shared Image Gallery. Changing this forces a new resource to be created.

  Example Input:
  ```
  resource_group_name = "my-resource-group"
  ```
  DESCRIPTION
}

variable "location" {
  type        = string
  description = <<DESCRIPTION
  * `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

  Example Input:
  ```
  location = "eastus"
  ```
  DESCRIPTION
}

variable "description" {
  type        = string
  description = <<DESCRIPTION
  * `description` - (Optional) A description for this Shared Image Gallery.

  Example Input:
  ```
  description = "An example shared image gallery"
  ```
  DESCRIPTION
}

variable "sharing" {
  type = object({
    permission = string
    community_gallery = optional(object({
      eula            = string
      prefix          = string
      publisher_email = string
      publisher_uri   = string
    }))
  })
  default     = null
  description = <<DESCRIPTION
  * `sharing` - (Optional) A `sharing` block as defined below. Changing this forces a new resource to be created.
    * `permission` - (Required) The permission of the Shared Image Gallery when sharing. Possible values are `Community`, `Groups` and `Private`. Changing this forces a new resource to be created.
    ~> **Note:** This requires that the Preview Feature `Microsoft.Compute/CommunityGalleries` is enabled, see [the documentation](https://learn.microsoft.com/azure/virtual-machines/share-gallery-community?tabs=cli) for more information.
    * `community_gallery` - (Optional) A `community_gallery` block as defined below. Changing this forces a new resource to be created.
    ~> **NOTE:** `community_gallery` must be set when `permission` is set to `Community`.
      * `eula` - (Required) The End User Licence Agreement for the Shared Image Gallery. Changing this forces a new resource to be created.
      * `prefix` - (Required) Prefix of the community public name for the Shared Image Gallery. Changing this forces a new resource to be created.
      * `publisher_email` - (Required) Email of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.
      * `publisher_uri` - (Required) URI of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.

  Example Input:
  ```
  # private gallery
  sharing = {
    permission = "Private"
  }

  #community gallery
  sharing = {
    permission = "Community"
  }
  ```
  DESCRIPTION
}

variable "shared_images_definitions" {
  type = map(object({
    name = string
    identifier = object({
      offer     = string
      publisher = string
      sku       = string
    })
    purchase_plan = optional(object({
      name      = string
      publisher = optional(string)
      product   = optional(string)
    }))
    os_type                             = string
    description                         = optional(string)
    disk_types_not_allowed              = optional(list(string))
    end_of_life_date                    = optional(string)
    eula                                = optional(string)
    specialized                         = optional(string)
    architecture                        = optional(string, "x64")
    hyper_v_generation                  = optional(string, "V1")
    max_recommended_vcpu_count          = optional(number)
    min_recommended_vcpu_count          = optional(number)
    max_recommended_memory_in_gb        = optional(number)
    min_recommended_memory_in_gb        = optional(number)
    privacy_statement_uri               = optional(string)
    release_note_uri                    = optional(string)
    trusted_launch_enabled              = optional(bool)
    trusted_launch_supported            = optional(bool)
    confidential_vm_supported           = optional(bool)
    confidential_vm_enabled             = optional(bool)
    accelerated_network_support_enabled = optional(bool)
    hibernation_enabled                 = optional(string)
    disk_controller_type_nvme_enabled   = optional(string)
    tags                                = optional(map(string))
  }))
  description = <<DESCRIPTION
  * `shared_images_definitions` - (Required) Manages a Shared Image within a Shared Image Gallery.
    * `name` - (Required) Specifies the name of the Shared Image. Changing this forces a new resource to be created.
    * `identifier` - (Required) An `identifier` block as defined below.
      * `offer` - (Required) The Offer Name for this Shared Image. Changing this forces a new resource to be created.
      * `publisher` - (Required) The Publisher Name for this Gallery Image. Changing this forces a new resource to be created.
      * `sku` - (Required) The Name of the SKU for this Gallery Image. Changing this forces a new resource to be created.
    * `os_type` - (Required) The type of Operating System present in this Shared Image. Possible values are `Linux` and `Windows`. Changing this forces a new resource to be created.
    * `purchase_plan` - (Optional) A `purchase_plan` block as defined below.
      * `name` - (Required) The Purchase Plan Name for this Shared Image. Changing this forces a new resource to be created.
      * `publisher` - (Optional) The Purchase Plan Publisher for this Gallery Image. Changing this forces a new resource to be created.
      * `product` - (Optional) The Purchase Plan Product for this Gallery Image. Changing this forces a new resource to be created.
    * `description` - (Optional) A description of this Shared Image.
    * `disk_types_not_allowed` - (Optional) One or more Disk Types not allowed for the Image. Possible values include `Standard_LRS` and `Premium_LRS`.
    * `end_of_life_date` - (Optional) The end of life date in RFC3339 format of the Image.
    * `eula` - (Optional) The End User Licence Agreement for the Shared Image. Changing this forces a new resource to be created.
    * `specialized` - (Optional) Specifies that the Operating System used inside this Image has not been Generalized (for example, `sysprep` on Windows has not been run). Changing this forces a new resource to be created.
    ~> **Note:** It's recommended to Generalize images where possible - Specialized Images reuse the same UUID internally within each Virtual Machine, which can have unintended side-effects.
    * `architecture` - (Optional) CPU architecture supported by an OS. Possible values are `x64` and `Arm64`. Defaults to `x64`. Changing this forces a new resource to be created.
    * `hyper_v_generation` - (Optional) The generation of HyperV that the Virtual Machine used to create the Shared Image is based on. Possible values are `V1` and `V2`. Defaults to `V1`. Changing this forces a new resource to be created.
    * `max_recommended_vcpu_count` - (Optional) Maximum count of vCPUs recommended for the Image.
    * `min_recommended_vcpu_count` - (Optional) Minimum count of vCPUs recommended for the Image.
    * `max_recommended_memory_in_gb` - (Optional) Maximum memory in GB recommended for the Image.
    * `min_recommended_memory_in_gb` - (Optional) Minimum memory in GB recommended for the Image.
    * `privacy_statement_uri` - (Optional) The URI containing the Privacy Statement associated with this Shared Image. Changing this forces a new resource to be created.
    * `release_note_uri` - (Optional) The URI containing the Release Notes associated with this Shared Image.
    * `trusted_launch_supported` - (Optional) Specifies if supports creation of both Trusted Launch virtual machines and Gen2 virtual machines with standard security created from the Shared Image. Changing this forces a new resource to be created.
    * `trusted_launch_enabled` - (Optional) Specifies if Trusted Launch has to be enabled for the Virtual Machine created from the Shared Image. Changing this forces a new resource to be created.
    * `confidential_vm_supported` - (Optional) Specifies if supports creation of both Confidential virtual machines and Gen2 virtual machines with standard security from a compatible Gen2 OS disk VHD or Gen2 Managed image. Changing this forces a new resource to be created.
    * `confidential_vm_enabled` - (Optional) Specifies if Confidential Virtual Machines enabled. It will enable all the features of trusted, with higher confidentiality features for isolate machines or encrypted data. Available for Gen2 machines. Changing this forces a new resource to be created.
    ~> **Note:**: Only one of `trusted_launch_supported`, `trusted_launch_enabled`, `confidential_vm_supported` and `confidential_vm_enabled` can be specified.
    * `accelerated_network_support_enabled` - (Optional) Specifies if the Shared Image supports Accelerated Network. Changing this forces a new resource to be created.
    * `hibernation_enabled` - (Optional) Specifies if the Shared Image supports hibernation. Changing this forces a new resource to be created.
    * `disk_controller_type_nvme_enabled` - (Optional) Specifies if the Shared Image supports NVMe disks. Changing this forces a new resource to be created.
    * `tags` - (Optional) A mapping of tags to assign to the Shared Image.

  Example Input:
  ```
  shared_images_definitions = {
    WindowsServer = {
      name = "WindowsServer-2022-hardened"
      identifier = {
        publisher = "CloudAstro"
        offer     = "WindowsServer-2022-hardened"
        sku       = "2022-datacenter-g2"
        version   = "0.1.0"
      }
      os_type     = "Windows"
      description = "Windows server 2022 Custom image"
    }
  ]
  ```
  DESCRIPTION
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = null
  description = <<DESCRIPTION
  * `tags` - (Optional) A mapping of tags to assign to the Shared Image Gallery.

  Example Input:
  ```
  tags = {
    "environment" = "production"
    "department"  = "IT"
  }
  ```
  DESCRIPTION
}
