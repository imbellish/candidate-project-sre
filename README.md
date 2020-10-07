# candidate-project-sre
This project assignment exercises the current technologies used at Aspen Capital and demonstrates typical work assignments. Please fork this repo and follow the instructions. Your deliverable will be a publicly available fork of this repo.

## Project Overview
You will create an Azure or AWS environment using **Terraform** and then configure the deployed resources using **Ansible**. The deployed application will be the `app/` folder provided here which is a simple Node.js web server. The architecture must match the following diagram with 3 small vms. The nginx reverse-proxy should use a simple round-robin load balancing scheme between 2 instances of the app running on separate virtual machines. You will need to create a free-tier account with either Azure or AWS to host your solution.

![architecture](./public/img/test-sre.png)

## Deliverables
Your solution will be evaluated based on these major components.
* Development Environment (VSCode devcontainer)
* Terraform Plan(s)
* Ansible Playbook(s) / Role(s)
* HTTP Accessible Application
* **(OPTIONAL)** CI/CD Pipeline (GitHub Actions)

### Development Environment
You will use a [Visual Studio Development Container](https://code.visualstudio.com/docs/remote/containers) to host your development environment so that any customizations made to your solution can be easily replicated. Please use `.devcontainer/Dockerfile` to construct your development environment and `.devcontainer/devcontainer.json` to control the deployment. Additional scripts and configurations for your developement container can be added to `.devcontainer/`, if needed.

### Terraform
Your terraform files must live under the `terraform/` directory.

### Ansible
Your ansible files must live under the `ansible/` directory.

### **(OPTIONAL)** CI/CD Pipeline
Create a CI/CD pipeline using GitHub actions to complete the following steps whenever there is a commit to the **master** branch of your solution.

1. **Terraform**: Deploy/Update cloud resources
1. **Ansible**: Configure cloud resources

## Submission
Your submission should be accessible in a public git repository where the nested `README.md` files have been populated with pertinent information. The expectation is that we can easily follow the steps provided and re-create your deliverables without much leg/guesswork. Please do not make updates to this main `README.md` file.
* [.devcontainer/README.md](.devcontainer/README.md)
* [ansible/README.md](ansible/README.md)
* [terraform/README.md](terraform/README.md)

If your submission does include additional artifacts that are not represented within the repository - include information on how to retrieve and access those items in the associated nested `README.md`.

## Referencing Code
If you reference and copy other published works be sure to clearly cite those works in your solution. For both Ansible and Terraform it is acceptable to use community packages:
* https://galaxy.ansible.com/
* https://registry.terraform.io/
