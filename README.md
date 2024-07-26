# Overview:

In this project we build the infrastructure for a three-tier application. This sample application, originally developed by Saurabh Dhingra, consists of a backend application built in .NET Core, a frontend application using HTML, CSS, and JavaScript, and a Postgres database. Originally it was a team project, which you find at: https://github.com/Chi91/DevOps_Infrastructrue_Automation

Teammembers:
- Farhan Reiser,
- Olha Kharabet,
- Annika Strooper,
- Chi Thien Pham

In the branches you can find several approaches, like kubernetes (minikube, eks, aks) or AWS LB and below you can find the original approach we decided on in the team.

## Project objectives

The main objective of the project were: 
- DevOps Practices: Implement and apply DevOps practices to manage the application lifecycle in a production environment.
- Automation: Automate provisioning, configuration, and infrastructure management using Terraform and Ansible.
- Containerization: Deploy and manage containerized applications to ensure scalability and consistency.
- Cloud Integration: Integrate the applications with AWS cloud services to leverage cloud-based features and scalability.

## Repository Structure:
- ansible: Installing docker on the EC2 machines, so we can run the containers
- docker: Containerizing the three tiers
  - api: The backend application code, builds the dependencies from the Basic3Tier.API repository.
  - ui: The frontend application code
- terraform: For building the infrastructure in AWS

## Architecture: 

![project-1](https://github.com/Chi91/DevOps_Infrastructrue_Automation/assets/97454726/fd8335e7-0375-428c-99e0-fdb0c2d5626d)








