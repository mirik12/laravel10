<!-- # TERRAFORM
## SUBTITLE

```bash
alias tf=terraform
``` -->

# Terraform AWS EKS Cluster

This repository contains Terraform code to create a basic Amazon EKS cluster.

## Directory Structure

.
├── **/*
│   ├── main.tf
│   ├── outputs.tf
│   ├── terraform.tf
│   ├── variables.tf
│   └── tfvars

## File Descriptions

- **main.tf**: The main Terraform file contains the primary resources and configurations for creating the EKS cluster.

- **variables.tf**: In this file, all the variables used in the project are declared. Variables can be environment variables, node size, other configuration parameters, etc.

- **outputs.tf**: This file contains output values that can be viewed after running Terraform. Outputs might include cluster endpoints, cluster names, security group IDs, etc.

- **terraform.tf**: Configuration file for Terraform settings.

- **tfvars**: A file where you can define variable values used in the project.

## Usage

1. Fill in the variable values in the `tfvars` file according to your requirements.

2. Run `terraform init` to initialize your project.

3. Run `terraform apply -var-file=tfvars` to create the EKS cluster.

4. After the `apply` command completes, print the output values to get information about your cluster.

## Notes

- Make sure you have correct AWS keys and API access configurations.

- Don't forget to check all the outputs to know the cluster URL and any other information that might be useful for your application.

## Commands for Terraform Lifecycle

- `terraform init`: Initialize your Terraform project.

- `terraform apply -var-file=tfvars`: Create or update the resources specified in your Terraform configuration.

- `terraform destroy -var-file=tfvars`: Destroy the Terraform-managed infrastructure.

---

*Author: [Myroslav Kyselytsia](mirik12mirik@gmail.com)*
