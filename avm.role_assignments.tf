module "avm-res-authorization-roleassignment" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "~> 0.0"

  system_assigned_managed_identities_by_principal_id = {
    virtual_machine = module.virtual_machine.virtual_machine_azurerm.identity[0].principal_id
  }

  role_definitions = {
    storage_blob_data_contributor = "Storage Blob Data Contributor"
  }

  role_assignments_for_scopes = {
    storage_container = {
      scope = module.storage_account.containers["demo"].id
      role_assignments = {
        contributor = {
          role_definition                    = "storage_blob_data_contributor"
          system_assigned_managed_identities = ["virtual_machine"]
        }
      }
    }
  }

  depends_on = [module.storage_account, module.virtual_machine]
}
