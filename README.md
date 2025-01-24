# Ansible with Jenkins, VM, Node.js, and Docker

This repository contains an Ansible-based automation setup for deploying a Jenkins CI/CD pipeline in a Virtual Machine (VM), integrated with Node.js and Docker. The setup leverages Ansible to automate the installation and configuration of Jenkins, Node.js, Docker, and related services on a target machine. The goal is to streamline the process of setting up a Jenkins-based CI/CD environment for software development and containerized applications.

---

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Usage](#usage)

---

## Features

- **Automated setup**: Use Ansible to configure Jenkins, Node.js, Docker, and other dependencies on a VM.
- **CI/CD pipeline**: Full Jenkins setup with Docker integration to run tests, build, and deploy containers.
- **Cross-platform**: Works with any system where Ansible can be used (Linux-based systems preferred).
- **Node.js integration**: Easily configure a Node.js environment to support backend and full-stack JavaScript applications.
- **Docker support**: Docker integration for containerized builds and deployments.

---

## Prerequisites

Before you begin, ensure you have the following installed and configured:

- **Ansible**: Used to automate the setup process.
  - Installation guide: [Ansible Installation](https://docs.ansible.com/ansible/latest/installation_guide/installation_index.html)
  
- **Jenkins**: The automation server that integrates with Ansible to set up the CI/CD pipeline.
  - [Jenkins Installation](https://www.jenkins.io/doc/book/installing/)

- **VM (Virtual Machine)**: This setup assumes you have access to a VM (e.g., using VMware, VirtualBox, or a cloud-based VM).
  - Ensure the VM is reachable via SSH for Ansible automation.

- **Docker**: Docker should be installed on your VM to handle containerized builds and deployments.
  - [Docker Installation](https://docs.docker.com/get-docker/)

---

## Getting Started

Follow these steps to set up Jenkins, Node.js, Docker, and related services on your VM:

### 1. Clone the repository:

		git clone https://github.com/Abdelaziz20598/ansible-with-jenkins-vm-node-docker.git
		cd ansible-with-jenkins-vm-node-docker

### 2. Configure your VM:

Run the SSH script to connect to your VM:

		./ansible-ssh.sh hosts.txt
	
### 3.Run the Ansible playbook:

Execute the playbook to configure Jenkins, Node.js, Docker, and other dependencies on your VM:

		ansible-playbook jenkins-install-roles.yml	

### 4. SSH to your VM:

After the playbook runs, you can SSH into your VM using the jenkins user to verify everything is correctly installed:

		ssh jenkins@<VM_IP>

### 5. Run Jenkins:

You can run Jenkins as a Docker container on your VM:

		docker run -d -p 8080:8080 -v jenkins_home:/var/jenkins_home --name jenkins jenkins/jenkins:lts

### 6. Access Jenkins:

Once Jenkins is running, you can access it in your browser:

		http://localhost:8080

### 7. Set up Jenkins credentials:

    GitHub: Add your GitHub credentials in Jenkins for repository access (you will need a personal access token for private repositories and note that to put the token instead of the github password in the credential).
    DockerHub: Add your DockerHub credentials.
    SSH: Add an SSH private key for authentication to other systems as needed.
    
### 8. Add the Node.js application repository:

    Link the Jenkins instance to the Node.js app repository that contains the Jenkinsfile and Docker image:
        Node.js Containerized App
        Note: This is a private repo, so you will need the appropriate GitHub credentials (personal access token).

### 9. Create the Jenkins pipeline:

Create a Jenkins pipeline job to run the repository. The pipeline should reference the Jenkinsfile in the Node.js app repository and build the Docker image for the Node.js app.

link github repo containing the jenkinsfile and the docker image of the nodejs app
		https://github.com/Abdelaziz20598/nodjs-container-app
note it is private



## Project Structure

    jenkins-install-roles.yml: The main Ansible playbook to automate the setup process.
    inventory/hosts.ini: Inventory file containing VM details (IP, SSH username, etc.).
    roles/: Directory containing Ansible roles for configuring Jenkins, Node.js, and Docker.
        roles/jenkins/: Role for installing and configuring Jenkins.
        roles/nodejs/: Role for installing Node.js.
        roles/docker/: Role for setting up Docker.

## Usage

Once Jenkins and the necessary services are installed, you can proceed with setting up your CI/CD pipeline in Jenkins.
Example Workflow:

    Create a new Jenkins job: Set up a new job for your project (e.g., a Node.js application).
    Configure Docker in Jenkins: Ensure Jenkins is configured to use Docker as a build environment.
    Set up GitHub integration: Configure Jenkins to pull from your GitHub repository to automatically trigger builds.
    Create build pipelines: Create Jenkins pipelines that utilize Docker for building and testing your application.
