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

## Ansible

To apply the application we're using ansible. So as a prerequisite you need to have ansible installed.
In the ansible code the community.docker collection is being used. Make sure you have it installed by running 'ansible-galaxy collection list' For further instructions see: [this link](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_image_build_module.html#ansible-collections-community-docker-docker-image-build-module-requirements)

### First Ansible run
Next, Ansible makes use of SSH, so please have logged into the hosts atleast once before running ansible. This is to make sure your hosts are added to the known_hosts. For ease, ping.yml is included. 

To run ansible:
1. 'cd ansible'
2. Run 'ansible-playbook ping.yml'

Right after you can install docker on all EC2 machines
3. Run 'ansible-playbook install-docker.yml'

When docker is installed on the EC2 machines, you can deploy the 3-tier-application.
4. Run 'ansible-playbook main.yml' 

## Access the website
You can access the website with the public ip of the frontend.




