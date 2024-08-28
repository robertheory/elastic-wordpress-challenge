# Create a security group for the EC2 instances and allow SSH and HTTP traffic
resource "aws_security_group" "wp-ec2-sg" {
  vpc_id = aws_vpc.wp-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from any IP. Add EC2 Instance Connect IP range as needed.
  }

  # Allow EC2 Instance Connect service IPs
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from any IP. Add EC2 Instance Connect IP range as needed.
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from any IP
  }

  # Allow communication with RDS on port 3306
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.wp-rds-sg.id] # Allow traffic from the RDS security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "wp-ec2-sg"
  }
}

# Create EC2 Instance for WordPress
resource "aws_instance" "wp-ec2" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_name
  subnet_id              = aws_subnet.wp-public-subnet.id
  vpc_security_group_ids = [aws_security_group.wp-ec2-sg.id]

  associate_public_ip_address = true # Ensure a public IP is assigned

  provisioner "remote-exec" {
    inline = [
      "echo 'Wait until SSH is ready'"
    ]

    connection {
      type        = "ssh"
      user        = var.provisioner_remote_exec_user
      private_key = file(var.provisioner_remote_exec_private_key)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_SSH_ARGS='-o StrictHostKeyChecking=no' ansible-playbook -i ${self.public_ip}, -u ${var.provisioner_remote_exec_user} --private-key=${var.ansible_private_key} ./playbooks/wordpress.yml --extra-vars \"db_host=${aws_db_instance.wp-rds.endpoint} db_name=${var.rds_db_name} db_user=${aws_db_instance.wp-rds.username} db_password=${aws_db_instance.wp-rds.password}\""
  }

  tags = {
    Name = "wp-ec2-instance"
  }
}
