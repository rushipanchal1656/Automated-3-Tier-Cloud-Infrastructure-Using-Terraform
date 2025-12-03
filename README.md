# Automated-3-Tier-Cloud-Infrastructure-Using-Terraform

This repository contains Terraform code to automate the deployment of a 3-tier cloud infrastructure on AWS. The infrastructure consists of a web tier, application tier, and database tier, each hosted in separate subnets for better security and scalability.

## Prerequisites

- An AWS account
- Terraform installed on your local machine
- AWS CLI configured with your credentials

## Directory Structure

```
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── modules
│   ├── web_tier
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── app_tier
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── db_tier
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

## Getting Started

1. Clone the repository:

   ```bash
    git clone
    cd Automated-3-Tier-Cloud-Infrastructure-Using-Terraform
    ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Review the Terraform plan:

   ```bash
    terraform plan
    ```

4. Apply the Terraform configuration:

    ```bash
     terraform apply
     ```

  Confirm the apply action by typing `yes` when prompted.

## Modules

- **Web Tier**: Contains resources for the web servers, including EC2 instances and security groups.
- **Application Tier**: Contains resources for the application servers, including EC2 instances and security groups.
- **Database Tier**: Contains resources for the database servers, including RDS instances and security groups.

## Outputs

After applying the Terraform configuration, you can find the outputs defined in `outputs.tf`, which may include:

- Public IP addresses of the web servers
- Endpoint of the application servers
- Database connection details

## Cleanup

To destroy the infrastructure created by this Terraform configuration, run:

```bash
terraform destroy
```

Confirm the destroy action by typing `yes` when prompted.

# Created By Rushikeah Panachal
