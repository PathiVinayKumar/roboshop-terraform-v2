resource "azurerm_public_ip" "frontend" {
  name                = "frontend"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
    for_each = var.components
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.key}-nic"
    subnet_id                     = "/subscriptions/9e27705f-e28f-4f14-9137-ef3f4f8924af/resourceGroups/Test/providers/Microsoft.Network/virtualNetworks/Monolith-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
        for_each = var.components

  name                  = "${each.key}"
  location              = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = each.value

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_id = var.image_id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

    admin_username = "vinay"
    admin_password = "Vinny@123456789"
 

   disable_password_authentication = false
  

  # These properties are typically part of a newer resource type (azurerm_linux_virtual_machine)
  # but added here for syntax compatibility with your snippet
  secure_boot_enabled = true
  vtpm_enabled        = true
}
 
resource "azurerm_dns_a_record" "main" {
            for_each = var.components
  name                = "${each.key}-dev"
  zone_name           = "vinaykumar.online"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.main.private_ip_address]
}
