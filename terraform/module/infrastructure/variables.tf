variable "region" {
  description = "AWS Region being used for deployment"
  type        = string
  default     = "eu-central-1"

}

variable "project_name" {
  description = "Name of project for this deployment"
  type        = string
  default     = "Devops_Infrastructure_Automation"

}

variable "vpc_cidr" {
  description = "Network space of the vpc, for example 172.168.0.0/16"
  type        = string
  default     = "192.168.0.0/16"

}

variable "subnet_count" {
  description = "Amount of subnets that need to be created"
  type        = number
  default     = 1
}

