variable "instance" {
  description = "Name of instances"
  type = map(object({
    subnet_name  = string
    port_numbers = list(number)
    }
  ))
  default = { "server" = { subnet_name = "subnet1", port_numbers = [80] } }

}

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

variable "vpc" {
  description = "ID and CIDR_block retrieved from infrastructure module"
  type = object({
    id         = string
    cidr_block = string
  })

}

variable "subnet" {
  description = "ID and cidr_block retrieved from infrastructure module"
  type = map(object({
    id         = string
    cidr_block = string
  }))
}

variable "ssh_key" {
  type = string
  description = "ssh key that will be given to the ec2 instances"
  default = ""
  
}