variable "region" {
  type        = string
  description = "AWS Region being used for deployment"
  default     = "eu-central-1"

}

variable "project_name" {
  type        = string
  description = "Name of project for this deployment"
  default     = "Devops_Infrastructure_Automation"

}

variable "vpc_cidr" {
  type        = string
  description = "Network space of the vpc, for example 172.168.0.0/16"
  default     = "192.168.0.0/16"

}

