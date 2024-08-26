# Elastic Wordpress Challenge

## Overview

The **Elastic Wordpress Challenge** is a final project designed for a course on cloud infrastructure and automation. The goal is to deploy a highly available, scalable, and secure WordPress site on AWS. The project involves using tools like Terraform for infrastructure as code, Ansible for automated configuration management, and Prometheus and Grafana for monitoring and observability.

## Objectives

The primary objective of this challenge is to create an automated deployment of a WordPress site on AWS, with additional requirements for monitoring and observability using Prometheus. The project will demonstrate an understanding of various AWS services, Terraform, and Ansible for creating and managing a scalable infrastructure.

## Requirements

### Mandatory Requirements

- **AWS Account:** A valid AWS account with sufficient permissions.
- **Terraform Installed:** Infrastructure as code using Terraform.
- **Ansible Knowledge:** Experience with Ansible for configuration management.
- **Basic Monitoring Setup:** At minimum, a basic monitoring or observability setup using Prometheus.

### Infrastructure to Provision with Terraform

- **VPC (Virtual Private Cloud):** Create a custom VPC to host all resources.
- **EC2 (Elastic Compute Cloud):** Deploy at least 2 Linux servers to host WordPress.
- **RDS (Relational Database Service):** Set up a managed database for WordPress.
- **High Availability Architecture:** Deploy resources across multiple availability zones.

### Optional Requirements

- **Memcached:** Configure Memcached for session storage.
- **EFS (Elastic File System):** Implement scalable and elastic storage for WordPress files.
- **Load Balancer:** Set up an AWS Load Balancer for distributing traffic across multiple EC2 instances.
- **Auto Scaling:** Enable auto-scaling to handle traffic spikes automatically.
- **CDN/WAF:** Integrate a CDN and Web Application Firewall for better performance and security.
  - **Cloudflare** or **AWS CloudFront** for CDN.
  - **AWS WAF** for application security.
- **Advanced Monitoring Setup:** Use Prometheus, Grafana, and 1P for observability.
- **Monitoring Indicators:** Create monitoring indicators for CPU, Memory, Disk, and HTTP Requests, or use "The Four Golden Signals" (Latency, Traffic, Errors, Saturation).

### Key AWS Services to Use

- **EC2 (Elastic Compute Cloud)**
- **VPC (Virtual Private Cloud)**
- **RDS (Relational Database Service)**
- **Elasticache (Memcached)**
- **Load Balancer (ELB/ALB)**
- **Autoscaling**
- **WAF (Web Application Firewall)**
- **CloudFront (Content Delivery Network)**

## Best Practices

- **Infrastructure as Code:** Use Terraform with variables, conditionals, loops, and modularization for maintainable code.
- **Ansible Configuration:** Use roles, variables, and modular code practices for configuring WordPress on EC2 instances.
- **Security Best Practices:** Apply best practices like IAM roles, security groups, and data encryption.
- **Monitoring and Observability:** Implement Prometheus and Grafana dashboards to monitor key metrics.

## Project Checklist

### Infrastructure Provisioning

- [ ] **Create a VPC** with public and private subnets in multiple availability zones.
- [ ] **Deploy EC2 Instances** in different availability zones for high availability.
- [ ] **Configure RDS** with a managed database for WordPress.
- [ ] **Set up ElastiCache with Memcached** (Optional) for session caching.
- [ ] **Implement EFS** (Optional) for scalable and elastic file storage.
- [ ] **Configure a Load Balancer** (Optional) for distributing traffic across EC2 instances.
- [ ] **Enable Auto Scaling** (Optional) to handle traffic spikes automatically.
- [ ] **Integrate CloudFront and WAF** (Optional) for CDN and enhanced security.

### Monitoring and Observability

- [ ] **Install Prometheus** on a dedicated server or container.
- [ ] **Configure Prometheus** to collect metrics from EC2 instances, RDS, and Load Balancer.
- [ ] **Install Grafana** on a dedicated server or container.
- [ ] **Create Grafana Dashboards** to visualize metrics such as CPU usage, memory usage, disk space, and HTTP request rates.
- [ ] **Set up Alerts** in Prometheus and Grafana based on SLAs, SLOs, SLIs, and Error Budgets.

### Best Practices

- [ ] **Use Terraform State Management** with S3 for remote state storage and DynamoDB for state locking.
- [ ] **Apply Security Best Practices** including IAM roles, security groups, and encrypted data storage.
- [ ] **Document Terraform and Ansible Configurations** for maintainability.
- [ ] **Review and Refactor Code** for Terraform and Ansible to improve readability and efficiency.

### Additional Considerations

- [ ] **Test High Availability and Failover** scenarios to ensure that the architecture works as expected in case of instance or availability zone failures.
- [ ] **Validate Performance** of the WordPress site under load to ensure it meets performance expectations.
- [ ] **Ensure Compliance with Security Policies** including network security and data protection regulations.

### Project Completion

- [ ] **Deploy WordPress** on EC2 instances with Ansible.
- [ ] **Configure WordPress** to connect to RDS and use Memcached (if applicable).
- [ ] **Verify Full Functionality** of the WordPress site and ensure all components are working together seamlessly.
- [ ] **Conduct Final Testing and Validation** to ensure all components are integrated correctly and meet the project requirements.

## Conclusion

By completing the above checklist, you will have successfully built a highly available, scalable, and secure WordPress environment on AWS, complete with automated deployment and monitoring capabilities.

Good luck with your Elastic Wordpress Challenge!

