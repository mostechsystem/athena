resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name.id
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id
}
  # Ensure that the random_pet resource is created before this
  depends_on = [random_pet.ssh_key_name]
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]

  # Ensure that the azapi_resource is created before this action
  depends_on = [azapi_resource.ssh_public_key]
}

output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
}
