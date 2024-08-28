# Region for AWS resources
variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

# Availability Zones for deploying resources
variable "availability_zones" {
  description = "The availability zones to deploy resources in."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# VPC CIDR block
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

# Public subnet CIDR block
variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

# Define the list of CIDR blocks for private subnets
variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"] # One for each AZ
}

# Instance type for EC2
variable "ec2_instance_type" {
  description = "The type of EC2 instance."
  type        = string
  default     = "t2.micro"
}

# AMI ID for EC2 instances
variable "ec2_ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-0e86e20dae9224db8"
}

# RDS configurations
variable "rds_instance_class" {
  description = "The instance class for RDS."
  type        = string
  default     = "db.t3.micro"
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ for RDS."
  type        = bool
  default     = false
}

variable "rds_storage_type" {
  description = "The storage type for RDS."
  type        = string
  default     = "gp2"
}

variable "rds_engine" {
  description = "The database engine for RDS."
  type        = string
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "The engine version for RDS."
  type        = string
  default     = "8.0"
}

variable "rds_username" {
  description = "The master username for RDS."
  type        = string
  default     = "wordpress" # Change this to a secure value
}

variable "rds_password" {
  description = "The master password for RDS."
  type        = string
  default     = "wordpress" # Change this to a secure value
}

variable "rds_db_name" {
  description = "The name of the database for RDS."
  type        = string
  default     = "wordpress"
}

# Key Pair for EC2 instances
variable "ec2_key_name" {
  description = "The key pair name for EC2 instances."
  type        = string
  default     = "wp-key"
}

# Provisioner configurations
variable "provisioner_remote_exec_user" {
  description = "The user for remote execution."
  type        = string
  default     = "ubuntu"
}

variable "provisioner_remote_exec_private_key" {
  description = "The private key for remote execution."
  type        = string
  default     = "./wp-key.pem"
}
