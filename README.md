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
| `main.avm.tf` | Terraform AVM modules declarations. |
| `main.non.avm.tf` | Terraform resources the are not supported by AVM yet. |
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

- HashiCorp Terraform CLI: [Download](https://www.terraform.io/downloads)
- Visual Studio Code: [Download](https://code.visualstudio.com/)
- Azure Terraform Extensiong for Visual Studio Code: [Download](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)
- HashiCorp Terraform Extension for Visual Studio Code: [Download](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- Azure CLI: [Download](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli#install-or-update)
- An Azure Subscription: [Free Account](https://azure.microsoft.com/en-gb/free/search/)

### Quickstart

The instructions for this sample are in the form of a Lab. Follow along with them to get up and running.

## Demo / Lab

### Create the Root Module

1. Create a new folder for the lab.
1. Open Visual Studio Code and open the new folder. Hint: `code .`
1. Create a new file called `terraform.tf` and add copy the code from [terraform.tf](terraform.tf) into it.
1. Create a new file called `main.tf` and add copy the code from [main.tf](main.tf) into it.

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
1. Run `az login` to login to your Azure subscription.
1. Follow the prompt to use the device code flow. WARNING!!!: Do not use <key>Ctrl+C</key> to copy as it will cancel the login process.
1. Once logged in, run `az account show` to check you are connected to the correct subscription. If not, run `az account set --subscription <subscription-id>` to change to the correct subscription.

### Create a blob in the storage account
1. Run `echo "hello world" > hello.txt` to create a file with some content.
1. Run `az storage blob upload --account-name <storage-account-name> --container-name demo --file hello.txt --name hello.txt --auth-mode login` to upload the file to the storage account.


## Resources

- [Terraform Steps for Azure DevOps](https://github.com/microsoft/azure-pipelines-terraform/blob/main/Tasks/TerraformTask/TerraformTaskV4/README.md))
- [Terraform azurerm provider OIDC configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_oidc)
- [Azure DevOps OIDC Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers)
- [Azure External Identity Docs](https://learn.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp)