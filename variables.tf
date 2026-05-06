variable "location" {
  default = "Denmark East"
}

variable "resource_group_name" {
  default = "Test"
}

variable "image_id" {
    default = "/subscriptions/9e27705f-e28f-4f14-9137-ef3f4f8924af/resourceGroups/Test/providers/Microsoft.Compute/galleries/rhel10/images/1.0.0"
  
}

variable "components" {
    default = {
        frontend = "Standard_B1s"
        mysql = "Standard_B1s"
        catalogue = "Standard_B1s"
        user = "Standard_B1s"
        mongodb = "Standard_B1s"
        cart = "Standard_B1s"
        shipping = "Standard_B1s"
    }
  
}