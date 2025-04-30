resource "azurerm_shared_image" "shared_image" {
  for_each                            = var.shared_images_definitions != null ? var.shared_images_definitions : {}
  name                                = each.value.name
  gallery_name                        = azurerm_shared_image_gallery.shared_image_gallery.name
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  os_type                             = each.value.os_type
  description                         = each.value.description
  disk_types_not_allowed              = each.value.disk_types_not_allowed
  end_of_life_date                    = each.value.end_of_life_date
  eula                                = each.value.eula
  specialized                         = each.value.specialized
  architecture                        = each.value.architecture
  hyper_v_generation                  = each.value.hyper_v_generation
  max_recommended_vcpu_count          = each.value.max_recommended_vcpu_count
  min_recommended_vcpu_count          = each.value.min_recommended_vcpu_count
  max_recommended_memory_in_gb        = each.value.max_recommended_memory_in_gb
  min_recommended_memory_in_gb        = each.value.min_recommended_memory_in_gb
  privacy_statement_uri               = each.value.privacy_statement_uri
  release_note_uri                    = each.value.release_note_uri
  trusted_launch_supported            = each.value.trusted_launch_supported
  trusted_launch_enabled              = each.value.trusted_launch_enabled
  confidential_vm_supported           = each.value.confidential_vm_supported
  confidential_vm_enabled             = each.value.confidential_vm_enabled
  accelerated_network_support_enabled = each.value.accelerated_network_support_enabled
  hibernation_enabled                 = each.value.hibernation_enabled
  tags                                = each.value.tags

  identifier {
    offer     = each.value.identifier.offer
    publisher = each.value.identifier.publisher
    sku       = each.value.identifier.sku
  }

  dynamic "purchase_plan" {
    for_each = each.value.purchase_plan != null ? [each.value.purchase_plan] : []
    content {
      name      = purchase_plan.value.name
      publisher = purchase_plan.value.publisher
      product   = purchase_plan.value.product
    }
  }
  depends_on = [azurerm_shared_image_gallery.shared_image_gallery]
}
