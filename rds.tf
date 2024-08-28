# Create a security group for the RDS instance
resource "aws_security_group" "wp-rds-sg" {
  vpc_id = aws_vpc.wp-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "wp-rds-sg"
  }
}

# Create RDS Instance
resource "aws_db_instance" "wp-rds" {
  allocated_storage = 20
  storage_type      = var.rds_storage_type
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  db_name           = var.rds_db_name
  username          = var.rds_username
  password          = var.rds_password
  multi_az          = var.rds_multi_az

  vpc_security_group_ids = [aws_security_group.wp-rds-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.wp-db-subnet-group.name

  # Disable automatic backups
  backup_retention_period = 0

  # Do not create a final snapshot before destroying the instance
  skip_final_snapshot = true

  tags = {
    Name = "wp-rds-instance"
  }
}

# Create a DB Subnet Group
resource "aws_db_subnet_group" "wp-db-subnet-group" {
  name       = "wp-db-subnet-group"
  subnet_ids = [aws_subnet.wp-private-subnet-az1.id, aws_subnet.wp-private-subnet-az2.id]

  tags = {
    Name = "wp-db-subnet-group"
  }
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = split(":", aws_db_instance.wp-rds.endpoint)[0]
  sensitive   = true
}

output "rds_db_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.wp-rds.db_name
}

output "rds_username" {
  description = "The username for the RDS instance"
  value       = aws_db_instance.wp-rds.username
}

output "rds_password" {
  description = "The password for the RDS instance"
  value       = aws_db_instance.wp-rds.password
  sensitive   = true
}
