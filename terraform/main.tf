module "main" {
  source = "./module/infrastructure"

  # Variables
  project_name = "Devops_Infrastructure_Automation"
  region       = "eu-central-1"
  vpc_cidr     = "192.168.0.0/16"

}


