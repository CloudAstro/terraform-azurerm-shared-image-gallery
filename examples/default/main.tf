resource "azurerm_resource_group" "gallery_rg" {
  name     = "rg-image-gallery-example"
  location = "germanywestcentral"
}

module "shared_image_gallery" {
  source              = "../.."
  name                = "imageGalleryName"
  location            = azurerm_resource_group.gallery_rg.location
  resource_group_name = azurerm_resource_group.gallery_rg.name
  description         = "Storage of hardenened base images"
  
  tags = {
    environment = "test"
  }
  

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
        publisher = "CloudAstro"
        sku       = "2022-datacenter-core-smalldisk-g2"
      }
    }
  }
}
