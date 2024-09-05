# Ansible and Terraform Integration Project

Overview: This project demonstrates the integration of Terraform and Ansible to automate the provisioning and configuration of a web server on AWS. It uses Terraform to create EC2 instances and Ansible to configure these instances, including setting up a web server with Nginx, copying files from a GitHub repository, and ensuring the web server is correctly set up.

Project Structure:

- main.tf: Terraform configuration file for provisioning EC2 instances and running Ansible playbooks.
- build.yml: Ansible playbook for setting up the web server.
- README.md: This file.

Prerequisites:
1. Terraform: Install Terraform on your local machine. Instructions can be found [here](https://learn.hashicorp.com/terraform/getting-started/install).
2. Ansible: Install Ansible on your Ansible controller machine. Instructions can be found [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
3. AWS CLI: Install and configure the AWS CLI. Instructions can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
4. SSH Key: Ensure you have an SSH key (`devops.pem`) for connecting to your EC2 instances.

Setup Instructions:

1. Clone the Repository

   
    git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
    cd YOUR_REPOSITORY
    

2. Configure Terraform

    - Edit `main.tf` to update any variables as needed, such as `BuildAMI`, `BuildType`, `BuildKey`, `SecurityGroupID`, and `AnsibleControllerIP`.

3. Initialize Terraform

   
    terraform init
    

4. Apply the Terraform Configuration

   
    terraform apply
   
    - This will create the EC2 instance and execute the Ansible playbook to configure it. Follow the prompts to confirm the creation.

5. Verify the Setup

    - After Terraform completes, you can check the output of the public IP of the instance. Access the web application using this IP address.


Usage

- Terraform: Used to provision the AWS infrastructure and trigger the Ansible playbook.
- Ansible: Used to configure the EC2 instance, install Nginx, clone a GitHub repository, and deploy a sample web application.



# Ansible Playbook Details

The `build.yml` playbook performs the following tasks:

1. Install Nginx: Ensures Nginx is installed and running on the EC2 instance.
2. Install Git: Installs Git to clone the GitHub repository.
3. Clone GitHub Repository: Clones the repository containing web files.
4. Copy Files to Nginx Directory: Copies files from the cloned repository to the Nginx directory.
5. Set Permissions: Sets appropriate permissions for the Nginx directory.
6. Restart Nginx: Restarts Nginx to apply changes.


Troubleshooting:-

- Host Key Verification Failed: Ensure the instance’s SSH key is added to the known hosts on the Ansible controller. You can disable host key checking in the `ansible-playbook` command by using the `-o StrictHostKeyChecking=no` option.
- Connection Refused: Make sure the EC2 instance is fully initialized and the security group allows inbound SSH traffic.

 
 Additional Information:

- Security Group: The security group used allows inbound SSH (port 22) and HTTP (port 80) traffic.
- Instance Configuration**: The EC2 instance is created using a specified AMI and instance type.


 - Contributing:  Feel free to open issues or submit pull requests if you have suggestions or improvements!

License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

