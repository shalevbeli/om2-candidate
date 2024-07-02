# om2-candidate

Welcome to OM2.
This repo holds the candidate excercise to help us guage technical profficiency.

## Discussion Exercise

- Implement the terraform code for the simplest possible EKS cluster with a single t3.micro node.
- Implement a github workflow that will run `terraform plan` and `terraform apply` on every push to the main branch or a PR against develop.
- Use pre-commit to ensure code standards are met.
- Document your changes
- Use `terraform test` framework to write a simple test of something in the code
- Check if there are any Terraform versions that should be updated in the codebase
- If possible create the cluster
- Once you have a cluster install some community helm chart on it.

## Practical Exercise

- Implement the terraform code for a simple EC2 instance based on Windows AMI with a single volume attached
- Create a simple PowerShell script to install an inputed list of Windows Features and rename the server before performing a restart
- Design a solution that will assist in managing the list of Windows Features to be installed on the server and a set of local users that should be created on the server, along with their secrets.


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
