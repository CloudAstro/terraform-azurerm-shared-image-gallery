resource "azurerm_shared_image_gallery" "shared_image_gallery" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  description         = var.description
  tags                = var.tags

  dynamic "sharing" {
    for_each = var.sharing != null ? [var.sharing] : []
    content {
      permission = sharing.value.permission
      dynamic "community_gallery" {
        for_each = sharing.value.community_gallery != null ? [sharing.value.community_gallery] : []
        content {
          eula            = community_gallery.value.eula
          prefix          = community_gallery.value.prefix
          publisher_email = community_gallery.value.publisher_email
          publisher_uri   = community_gallery.value.publisher_uri
        }
      }
    }
  }
}
