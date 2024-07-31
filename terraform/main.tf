provider "aws" {
  region = "eu-central-1"

}

module "main" {
  source = "./module/infrastructure"

  # Variables
  project_name = "devops-infrastructure-automation"
  region       = "eu-central-1"
  vpc_cidr     = "192.168.0.0/16"
  subnet_count = 3

}

module "resource" {
  source = "./module/resource"

  #Variables
  ssh_key = "annika-mykey"
  instance = {
    "frontend" = {
      subnet_name = "subnet1"
      port_numbers = [80, 22]
    },
    "backend" = {
      subnet_name = "subnet2"
      port_numbers = [80, 22]
    },
    "database" = {
      subnet_name = "subnet3"
      port_numbers = [5432, 22]
  } }

  #Variables from module.main output
  project_name = module.main.project_name
  region       = module.main.region
  vpc          = module.main.vpc
  subnet       = module.main.subnet
  alb_arn = module.main.alb_arn  

}

output "ip" {
  value = module.resource.ip
  
}

output "dns" {
  value = module.main.alb_dns
  
}
