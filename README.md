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
| `labs` | The files for the lab. |
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
* Git: [Download](https://git-scm.com/downloads)
* Visual Studio Code: [Download](https://code.visualstudio.com/)
  * Azure Terraform Extension for Visual Studio Code: [Install](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)
  * HashiCorp Terraform Extension for Visual Studio Code: [Install](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
* Azure CLI: [Download](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli#install-or-update)
* An Azure Subscription: [Free Account](https://azure.microsoft.com/en-gb/free/search/)

### Quickstart

The instructions for this sample are in the form of a Lab. Follow along with them to get up and running.

## Demo / Lab

### Part 0 - Get the lab files

In this part we are going to get a local copy of the lab files for use in the rest of the lab.

1. Create a new folder for the lab in a location of your choice.
1. Open a terminal and navigate to the new folder.
1. Run `git clone https://github.com/Azure-Samples/avm-terraform-labs` to clone the lab files into the new folder, they will be in a subfolder called `avm-terraform-labs`.

### Part 1 - Base files and resources

In this part we are going to setup our Terraform root module and deploy an Azure Resoure Group ready for the rest of the lab.

1. Create a new folder under your lab folder called `avm-lab`.
1. Copy the files from the [part 1](labs/part01-base/) folder into the `avm-lab` folder.
1. Open Visual Studio Code and open the `avm-lab` folder. Hint: `code .`
1. Examine the `terraform` block in `terraform.tf` and note that we are referencing the `azurerm` and `random` providers.
1. Examine the `locals.tf`, `variables.tf`, `outputs.tf` and `main.tf` files.
1. Create a file called `terraform.tfvars` and add the following code to it, ensuring you replace the placeholder for a valid Azure location of your choice (e.g. uksouth):

  ```hcl
  location = "<azure region>"
  tags = {
    type = "avm"
    env  = "demo"
  }
  ```

7. Open a terminal in Visual Studio Code and ensure you are in the root of your `avm-lab` folder.
1. Run `az login` to login to your Azure subscription.
1. Run `az account show` to show the current subscription. Run `az account set --subscription <subscription-id>` to set the subscription if it is not the one you want to use.
1. Run `terraform init` to initialize the Terraform configuration.
1. Run `terraform plan -out tfplan` to see what resources will be created and create a plan file.
1. Run `terraform apply tfplan` to create the resources based on the plan file.
1. Navigate to the Azure Portal and review the resources that have been created.
1. Run `git init` to initialize a new git repository.
1. Run `git add .` to stage the files.
1. Run `git commit -m "Initial commit"` to commit the files.

### Part 2 - Virtual network and subnets

In this part we are going to add a virtual network and subnets to our Terraform configuration by leveraging the Azure Verified Module for Virtual Network. The Virtual Network is going to be used to provide private connnectivity between and to our virtual machine, key vault and storage account.

1. Copy the files from the [part 2](labs/part02-vnet/) folder into the `avm-lab` folder, replacing the existing files when prompted.
1. Open your `terraform.tfvars` and update it with the following code, ensuring you replace the placeholder for a valid Azure location of your choice (e.g. uksouth):

  ```hcl
  location               = "<azure region>"
  address_space_start_ip = "10.0.0.0"
  address_space_size     = 16
  subnets_and_sizes = {
    AzureBastionSubnet = 24
    private_endpoints  = 28
    virtual_machines   = 24
  }
  tags = {
    type = "avm"
    env  = "demo"
  }
  ```

3. Run `terraform init -upgrade` to install the AVM module for Virtual Networks.
1. Navigate to the `Source Control` tab in Visual Studio Code and review the changes to the files.
1. Open the `avm.virtual-network.tf` file and look at each of the properties, paying close attention to the `source` and `version` properties.
1. Apply the changes with Terraform. Hint: `terraform apply -auto-approve`.
1. Review the deployed resources in the Azure Portal.
1. Commit the changes to git.

### Part 3 - Key Vault

In this part we are going to add a Key Vault to our Terraform configuration by leveraging the Azure Verified Module for Key Vault. The Key Vault is going to be used to store the customer managed key for our storage account and the SSH private key for our virtual machine.

1. Copy the files from the [part 3](labs/part03-keyvault/) folder into the `avm-lab` folder, replacing the existing files when prompted.
1. Run `terraform init -upgrade` to install the AVM module for Key Vault.
1. Navigate to the `Source Control` tab in Visual Studio Code and review the changes to the files.
1. Open the `avm.key-vault.tf` file and look at each of the properties, paying close attention to the `private_endpoints` and `role_assigments` variables.
1. Apply the changes with Terraform.
1. Review the deployed resources in the Azure Portal.
1. Commit the changes to git.

### Part 4 - Storage account

In this part we are going to add a Storage Account to our Terraform configuration by leveraging the Azure Verified Module for Storage Account. The Storage Account is the main component of our demo lab and we will interact with it later on.

1. Copy the files from the [part 4](labs/part04-storage-account/) folder into the `avm-lab` folder, replacing the existing files when prompted.
1. Run `terraform init -upgrade` to install the AVM module for Storage Account.
1. Navigate to the `Source Control` tab in Visual Studio Code and review the changes to the files.
1. Open the `avm.storage-account.tf` file and look at each of the properties, paying close attention to the `managed_identities`, `customer_managed_key` and `containers` variables.
1. Note in the source control diff that we are adding a key to the Key Vault using the AVM module and assigning permissions for the user assigned managed identity to access the key.
1. Apply the changes with Terraform.
1. Review the deployed resources in the Azure Portal.
1. Commit the changes to git.

### Part 5 - Virtual machine and Bastion

In this part we are going to add a Virtual Machine to our Terraform configuration by leveraging the Azure Verified Module for Virtual Machine. The Virtual Machine is going to be used to interact with the Storage Account later. We are also going to leverage the Role Assignments Azure Verified Module to assign permissions to the managed identity of the virtual machine to the storage account.

1. Copy the files from the [part 5](labs/part05-vm/) folder into the `avm-lab` folder, replacing the existing files when prompted.
1. Run `terraform init -upgrade` to install the AVM modules for Virtual Machine and Role Assignments.
1. Apply the changes with Terraform. NOTE: We are applying this now, because the bastion can take a few minutes to deploy.
1. Navigate to the `Source Control` tab in Visual Studio Code and review the changes to the files.
1. Open the `avm.virtual-machine.tf` file and look at each of the properties, paying close attention to the `admin_credential_key_vault_resource_id` and `network_interfaces` variables.
1. Open the `avm.role-assignments.tf` file and look at each of the properties.
1. Review the deployed resources in the Azure Portal.
1. Commit the changes to git.

### Part 6 - Connect to the VM via Bastion

In this part we are going to connect to the virtual machine via the Azure Bastion service using the SSH private key stored in the Key Vault.

1. Open the Azure Portal and navigate to the VM.
1. Click on the `Connect` button and select `Bastion`.
1. Choose `SSH Private Key from Azure Key Vault` in the `Authentication Type` dropdown.
1. Enter `azureuser` in the `Username` field.
1. Select you subscription from the `Subscription` drop down.
1. Select the Key Vault you created in the lab in the `Azure Key Vault` drop down.
1. Select the secret you created in the lab in the `Azure Key Vault Secret` drop down.
1. Click `Connect`.
1. A new browser window will open with a terminal session to the VM.

### Part 7 - Install the Azure CLI and login

We are going to install the Azure CLI and login with the system assigned managed identity of the VM from the Azure Bastion SSH terminal.

1. Run `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash` to install the Azure CLI.
1. Run `az login --identity` to login with the system assigned managed identity.

### Create a blob in the storage account

We are going to create a blob in the storage account using the Azure CLI form the Azure Bastion SSH terminal.

1. Run `echo "hello world" > hello.txt` to create a file with some content.
1. Run `az storage blob upload --account-name <storage-account-name> --container-name demo --file hello.txt --name hello.txt --auth-mode login` to upload the file to the storage account.
1. Run `az storage blob list --account-name <storage-account-name> --container-name demo --auth-mode login` to list the blobs in the container.
1. Run `az storage blob download --account-name <storage-account-name> --container-name demo --name hello.txt --file hello2.txt --auth-mode login` to download the blob to a new file.
1. Run `cat hello2.txt` to view the contents of the downloaded file.

Here are the commands to run, so you can copy to notepad and replace the placeholder with the storage account name you created in the lab. Then run the commands in the terminal:

```bash
echo "hello world" > hello.txt
az storage blob upload --account-name replace_me --container-name demo --file hello.txt --name hello.txt --auth-mode login
az storage blob list --account-name replace_me --container-name demo --auth-mode login
az storage blob download --account-name replace_me --container-name demo --name hello.txt --file hello2.txt --auth-mode login
cat hello2.txt
```

### Clean up

Finally we will clean up everything we have created in the lab.

1. Run `terraform destroy` from the Visual Studio Code terminal to remove the resources created by Terraform.
1. When prompted type `yes` and press `Enter` to confirm the destruction.

## Resources

* AVM Documentation: [Azure Verified Modules](https://aka.ms/avm)
