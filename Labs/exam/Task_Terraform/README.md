# AWS Infrastructure with Terraform

## Architecture

- VPC with configurable CIDR block
- Multiple public and private subnets across availability zones
- Internet Gateway for public subnet access
- EC2 instances in public subnets
- Application Load Balancer with autoscaling capabilities

## Prerequisites

- Terraform installed
- AWS credentials configured
- AWS CLI installed

## Modules

### Network Module
- Creates VPC infrastructure
- Configurable public and private subnets
- Handles routing tables and internet gateway

### EC2 Module
- Deploys EC2 instances in public subnets
- Configurable instance type and AMI
- Security group with HTTP and SSH access

### ALB Module
- Application Load Balancer with HTTP listener
- Autoscaling group with configurable min/max instances
- Health checks and target group configuration

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the deployment plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## Configuration Variables

### Root Level
- `region`: AWS region (default: us-east-1)

### Network Module
- `cider_block_range`: VPC CIDR block size (default: 16)
- `subnet_count_public`: Number of public subnets (default: 2)
- `subnet_count_private`: Number of private subnets (default: 1)

### EC2 Module
- `instance_type`: EC2 instance size (default: t2.micro)
- `assign_public_ip`: Toggle public IP assignment (default: true)

### ALB Module
- `instance_type`: Instance type for ASG (default: t2.micro)
- `min_size`: Minimum number of instances (default: 1)
- `max_size`: Maximum number of instances (default: 3)

## Security

- ALB security group allows inbound HTTP (port 80)
- EC2 instances allow inbound HTTP from ALB only
- Public instances allow SSH access (port 22)
- All outbound traffic is allowed

## Outputs

- VPC details via `vpc_output`
- EC2 instance details via `ec2_output`
- ALB DNS name via `alb_output`

