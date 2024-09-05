
provider "aws" {
  region = "ap-south-1"
}

# Variables for EC2 instance
variable "BuildAMI" {
  description = "Build Server AMI"
  default     = "ami-0522ab6e1ddcc7055"
}

variable "BuildType" {
  description = "Build Server Type"
  default     = "t2.micro"
}

variable "BuildKey" {
  description = "Build Server Key"
  default     = "devops"
}

variable "BuildUser" {
  description = "Build User"
  default     = "ubuntu"
}

variable "SecurityGroupID" {
  description = "Security Group ID"
  default     = "sg-0a4b86efefd9999b7"
}

variable "AnsibleControllerIP" {
  description = "Ansible Controller IP"
  default     = "172.31.11.61"
}

# EC2 Instance Configuration
resource "aws_instance" "example" {
  ami                    = var.BuildAMI
  instance_type          = var.BuildType
  key_name               = var.BuildKey
  vpc_security_group_ids = [var.SecurityGroupID]

  tags = {
    Name = "Node3"
  }
}

# Null resource to handle waiting for the instance and executing the Ansible playbook
resource "null_resource" "ansible_playbook" {
  depends_on = [aws_instance.example]

  provisioner "local-exec" {
    command = <<EOT
      # Wait for the EC2 instance to be reachable via SSH
      while ! nc -zv ${aws_instance.example.public_ip} 22; do
        echo "Waiting for instance SSH..."
        sleep 10
      done

      # Copy the Ansible playbook from local /tmp directory to the Ansible controller
      scp -i /etc/ansible/devops.pem /tmp/build.yml ubuntu@${var.AnsibleControllerIP}:/tmp/build.yml


      # Run the Ansible playbook on the Ansible controller
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
      -i /etc/ansible/devops.pem ubuntu@${var.AnsibleControllerIP} \
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /tmp/build.yml -i ${aws_instance.example.private_ip}, -u ubuntu --private-key /etc/ansible/devops.pem"
    
    EOT
  }
}

# Output the public and private IP of the instance
output "public_ip" {
  value = aws_instance.example.public_ip
}

output "private_ip" {
  value = aws_instance.example.private_ip
}
