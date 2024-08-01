# instructions

## Terraform
Before you can apply the terraform code you define in the main.tf:
- region
- project_name 
- vpc_cidr
- subnet_count

In the next module you define how many instances you want, in which subnet and which ports it requires. Additionally, you need an AWS SSH key, you need to provide its name as input in the main.tf. In the configuration it is assumed you're key is a pem file and its placed in the root folder.

You start applying the terraform code with.
1. 'cd terraform'
2. 'terraform init'
3. 'terraform plan'
4. 'terraform apply'





