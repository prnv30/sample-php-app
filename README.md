# Sample PHP Yii2 Application with CI/CD & Ansible Automation

This repository contains a simple PHP Yii2 application, along with fully automated deployment and infrastructure provisioning workflows. The primary focus of this repo is on the automation aspects including:

- A GitHub Actions CI/CD workflow that builds, versions, tags, and deploys the app container to a Docker Swarm cluster hosted on an EC2 instance.
- Ansible playbooks to set up the EC2 environment including Docker, Docker Swarm, and Nginx as a reverse proxy to serve the PHP app container.

---

## Table of Contents

- [Project Overview](#project-overview)  
- [Setup Instructions](#setup-instructions)  
- [GitHub Actions CI/CD Workflow](#github-actions-cicd-workflow)  
- [Ansible Playbooks](#ansible-playbooks)  
- [Assumptions](#assumptions)  
- [How to Test Deployment](#how-to-test-deployment)  
- [Repository Structure](#repository-structure)  
- [Contact / Support](#contact--support)  

---

## Project Overview

This repo hosts a minimal PHP Yii2 application intended as a demo app for showcasing deployment automation using modern DevOps practices:

- The PHP app itself is minimal, just to demonstrate containerization and deployment.
- The main focus is on the **GitHub Actions** workflow that builds Docker images with semantic versioning, pushes images to Docker Hub, and triggers deployment to a Docker Swarm cluster on EC2.
- The **Ansible playbooks** automate environment provisioning on EC2 instances to ensure a consistent and repeatable setup with Docker, Docker Swarm, and Nginx reverse proxy.

---

## Setup Instructions

### Prerequisites

- GitHub repository configured with this code
- Docker Hub account and repository created for storing images
- AWS EC2 instance (Amazon Linux or CentOS recommended) for deployment
- SSH access configured to EC2 instance
- GitHub Secrets configured:
  - `GH_PAT` - GitHub Personal Access Token (for pushing tags)
  - `DOCKERHUB_TOKEN` - Docker Hub access token/password
  - `SSH_PRIVATE_KEY` - Private SSH key to connect to EC2
  - `SSH_HOST` - EC2 instance hostname or IP
- GitHub Environment named `DEV` configured with required protection rules for gated deployment

### Local Setup

1. Clone the repo:

```bash
git clone https://github.com/<your_org>/<your_repo>.git
cd <your_repo>


## 🚀 GitHub Actions CI/CD Workflow

The GitHub Actions workflow is triggered on every push to the `main` branch and performs the following steps:

1. **Checkout**
   - Checks out the repository with full history.
   - Fetches tags to determine the next semantic version bump (patch increment).

2. **Versioning**
   - Tags the repo with the new version.
   - Pushes the new tag to the repository.

3. **Docker Build and Push**
   - Logs into Docker Hub using stored secrets.
   - Builds the Docker image and tags it with both:
     - The new semantic version.
     - `latest`
   - Pushes both tags to Docker Hub.

4. **Remote Deployment via SSH**
   - Connects to the target EC2 instance.
   - Pulls the updated Docker image.
   - Updates the Docker Swarm service (`php-app`) with the new image version.

5. **Security**
   - All deployments are gated through the **GitHub Environment `DEV`** to enforce manual approval or required checks before proceeding.

---

## ⚙️ Ansible Playbooks

The main playbook (`ansible/configure.yml`) automates the following on the EC2 instance:

- Installs **Docker** and **Nginx**.
- Ensures Docker and Nginx services are started and enabled on boot.
- Adds `ec2-user` to the Docker group for permission handling.
- Initializes Docker Swarm (if not already done).
- Creates a Docker Swarm service to run the PHP application.
- Deploys an **Nginx reverse proxy** configured via `nginx.conf.j2` to route traffic to the PHP app container.

---

## 🛠️ How to Run the Ansible Playbook

1. **Inventory Setup**

   Make sure your `ansible/hosts` inventory file includes your EC2 instance under the `[ec2]` group.

2. **Run the Playbook**

   ```bash
   ansible-playbook -i ansible/hosts ansible/configure.yml --ask-become-pass
