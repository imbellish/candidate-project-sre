# candidate-project-sre
This project assignment exercises the current technologies used at Aspen Capital and demonstrates typical work assignments. Please fork this repo and follow the instructions. Your deliverable will be a publicly available fork of this repo.

## Project Overview
You will create an Azure or AWS environment using **Terraform** and then configure the deployed resources using **Ansible**. The deployed application will be the `app/` folder provided here which is a simple Node.js web server. The architecture must match the following diagram with 3 small vms. The nginx reverse-proxy should use a simple round-robin load balancing scheme between 2 instances of the app running on separate virtual machines. You will need to create a free-tier account with either Azure or AWS to host your solution.

![architecture](./public/img/test-sre.png)

## Deliverables
Your solution will be evaluated based on these major components.
* Development Environment (Codespace)
* Terraform Plan(s)
* Ansible Playbook(s) / Role(s)
* HTTP Accessible Application
* **(OPTIONAL)** CI/CD Pipeline (GitHub Actions)

### Development Environment
You will use Visual Studio Codespaces to host your development environment so that any customizations made to solution can be easily replicated. You will need to sign up for a free Azure Subscription, see [Visual Studio Codespaces VS Code How-to](https://docs.microsoft.com/en-us/visualstudio/codespaces/how-to/vscode). Your project will be evaluated as a cloud-hosted codespace, so please ensure that your repo works in a codespace upon submission.

* use default instance type: Linux 4 cores and 8GB RAM
* load all necessary tools, see [Configure Codespace Environments](https://docs.microsoft.com/en-us/visualstudio/codespaces/reference/configuring)
    * Terraform
    * Ansible
    * Node.js
    * _any other utilities required to run your solution_

Please use `.devcontainer/Dockerfile` for your customizations (**NOTE**: codespaces does not support dynamically loading the environment. You will have to destroy your codespace and recreate it to see your changes after pushing your updates to GitHub.) For a faster development cycle, use `Remote-Containers: Reopen in Container...` to test your development environment locally.

### Terraform
Your terraform files must live under the `terraform` directory.

You can re-use your Azure subscription required for the codespace to host your resources or you can create a free-tier account with AWS.

### Ansible
Your ansible files must live under the `ansible` directory.

### **(OPTIONAL)** CI/CD Pipeline
Create a CI/CD pipeline using GitHub actions to complete the following steps whenever there is a commit to the **master** branch of your solution.

1. **Terraform**: Deploy/Update cloud resources
1. **Ansible**: Configure cloud resources

## Submission
* Your submission should be accessible in a public git repository where the nested `README.md` files have been populated with pertinent information. The expectation is that we can easily follow the steps provided and re-create your deliverables without much leg/guesswork. Please do not make updates to this main `README.md` file.
    * [.devcontainer/README.md](.devcontainer/README.md)
    * [ansible/README.md](ansible/README.md)
    * [terraform/README.md](terraform/README.md)
* If your submission does include additional artifacts that are not represented within the repository - include information on how to retrieve and access those items in the associated nested `README.md`.

## Referencing Code
If you reference and copy other published works be sure to clearly cite those works in your solution.
