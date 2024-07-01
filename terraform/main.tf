provider "aws" {
  region = "eu-central-1"

}

module "main" {
  source = "./module/infrastructure"

  # Variables
  project_name = "Devops_Infrastructure_Automation"
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
    },
    "backend" = {
      subnet_name = "subnet2"
    },
    "database" = {
      subnet_name = "subnet3"
  } }

  #Variables from module.main output
  project_name = module.main.project_name
  region       = module.main.region
  vpc          = module.main.vpc
  subnet       = module.main.subnet

}
