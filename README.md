---
page_type: sample
languages:
- terraform
- hcl
name: Introduction to using Azure Verified Modules for Terraform
description: A walk through lab demonstrating how to use the Azure Verified Modules for Terraform.
products:
- azure
urlFragment: avm-terraform-labs
---

# Introduction to using Azure Verified Modules for Terraform

This is a lab based sample that demonstrates how to use the Azure Verified Modules for Terraform. The repository contains the full working solution, but you should follow the steps in the lab to understand how it fits together.

## Content

| File/folder | Description |
|-------------|-------------|
| `data.tf` | Terraform read-only resources. |
| `locals.tf` | Terraform locals and calculations. |
| `main.tf` | Terraform core resources. |
| `avm.*.tf` | Terraform AVM modules declarations. |
| `non.avm.tf` | Terraform resources the are not supported by AVM yet. |
| `variables.tf` | Terraform inputs. |
| `outputs.tf` | Terraform outputs. |
| `terraform.tf` | Terraform provider declarations. |
| `.gitignore` | Define what to ignore at commit time. |
| `CHANGELOG.md` | List of changes to the sample. |
| `CONTRIBUTING.md` | Guidelines for contributing to the sample. |
| `README.md` | This README file. |
| `LICENSE.md` | The license for the sample. |

## Features

This sample deploys the following features:

* Virtual network
* Subnets
* Network security groups
* Virtual machines
* Managed identities
* Key Vault
* Storage account with customer managed key
* Private end points and associated private DNS zones

## Getting Started

### Prerequisites

* HashiCorp Terraform CLI: [Download](https://www.terraform.io/downloads)
* Visual Studio Code: [Download](https://code.visualstudio.com/)
* Azure Terraform Extensiong for Visual Studio Code: [Download](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)
* HashiCorp Terraform Extension for Visual Studio Code: [Download](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
* Azure CLI: [Download](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli#install-or-update)
* An Azure Subscription: [Free Account](https://azure.microsoft.com/en-gb/free/search/)

### Quickstart

The instructions for this sample are in the form of a Lab. Follow along with them to get up and running.

## Demo / Lab

### Create the Root Module

We have prepped some files for you to use that configure variables, outputs, providers, etc. Review each file as you create it to understand what it does.

1. Create a new folder for the lab.
1. Open Visual Studio Code and open the new folder. Hint: `code .`
1. Create a new file called `terraform.tf` and add copy the code from [terraform.tf](terraform.tf) into it.
1. Create a new file called `main.tf` and add copy the code from [main.tf](main.tf) into it.
1. Create a new file called `variables.tf` and add copy the code from [variables.tf](variables.tf) into it.
1. Create a new file called `outputs.tf` and add copy the code from [outputs.tf](outputs.tf) into it.
1. Create a new file called `locals.tf` and add copy the code from [locals.tf](locals.tf) into it.
1. Create a new file called `data.tf` and add copy the code from [data.tf](data.tf) into it.
1. Create a new file called `non.avm.tf` and add copy the code from [non.avm.tf](non.avm.tf) into it.

### Add the AVM references

The following files demonstrate how to use the Azure Verified Modules for Terraform.

1. Create a new file called `avm.virtual_network.tf` and copy the code from [avm.virtual_network.tf](avm.virtual_network.tf) into it.
1. Create a new file called `avm.key_vault.tf` and copy the code from [avm.key_vault.tf](avm.key_vault.tf) into it.
1. Create a new file called `avm.storage_account.tf` and copy the code from [avm.storage_account.tf](avm.storage_account.tf) into it.
1. Create a new file called `avm.virtual_machine.tf` and copy the code from [avm.virtual_machine.tf](avm.virtual_machine.tf) into it.
1. Create a new file called `avm.role_assignments.tf` and copy the code from [avm.role_assignments.tf](avm.role_assignments.tf) into it.

### Create variables

1. Create a new file called `terraform.tfvars` and add the following code to it:

```hcl
location               = "<a valid azure location of your choice>"
address_space_start_ip = "10.0.0.0"
address_space_size     = 16
subnets_and_sizes = {
  AzureBastionSubnet = 24
  private_endpoints  = 28
  virtual_machines   = 24
}
```

### Apply the Terraform configuration

1. Open a terminal in Visual Studio Code.
1. Run `az login` to login to your Azure subscription.
1. Run `az account show` to show the current subscription. Run `az account set --subscription <subscription-id>` to set the subscription if it is not the one you want to use.
1. Run `terraform init` to initialize the Terraform configuration.
1. Run `terraform plan -out tfplan` to see what resources will be created.
1. Run `terraform apply tfplan` to create the resources.
1. Navigate to the Azure Portal and review the resources that have been created.

### Connect to the VM via Bastion

1. Open the Azure Portal and navigate to the VM.
1. Click on the `Connect` button and select `Bastion`.
1. Choose `SSH Private Key from Azure Key Vault` in the `Authentication Type` dropdown.
1. Enter `azureuser` in the `Username` field.
1. Select you subscription from the `Subscription` drop down.
1. Select the Key Vault you created in the lab in the `Azure Key Vault` drop down.
1. Select the secret you created in the lab in the `Azure Key Vault Secret` drop down.
1. Click `Connect`.
1. A new browser window will open with a terminal session to the VM.

### Install the Azure CLI and login

1. Run `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash` to install the Azure CLI.
1. Run `az login --identity` to login with the system assigned managed identity.

### Create a blob in the storage account

1. Run `echo "hello world" > hello.txt` to create a file with some content.
1. Run `az storage blob upload --account-name <storage-account-name> --container-name demo --file hello.txt --name hello.txt --auth-mode login` to upload the file to the storage account.
1. Run `az storage blob list --account-name <storage-account-name> --container-name demo --auth-mode login` to list the blobs in the container.
1. Run `az storage blob download --account-name <storage-account-name> --container-name demo --name hello.txt --file hello2.txt --auth-mode login` to download the blob to a new file.
1. Run `cat hello2.txt` to view the contents of the downloaded file.

Here are the commands to run, so you can copy to notepad and replace the placeholder with the storage account name you created in the lab. Then run the commands in the terminal:

```bash
echo "hello world" > hello.txt`
az storage blob upload --account-name replace_me --container-name demo --file hello.txt --name hello.txt --auth-mode login
az storage blob list --account-name replace_me --container-name demo --auth-mode login
az storage blob download --account-name replace_me --container-name demo --name hello.txt --file hello2.txt --auth-mode login
cat hello2.txt
```

### Clean up

1. Run `terraform destroy` from the Visual Studio Code terminal to remove the resources created by Terraform.

## Resources

* AVM Documentation: [Azure Verified Modules](https://aka.ms/avm)
