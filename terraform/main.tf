provider "aws" {
  region = "us-west-2"
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

#provider "docker" {}
#
#resource "docker_image" "nginx" {
#  name         = "nginx:latest"
#  keep_locally = false
#}
#
#resource "docker_container" "nginx" {
#  image = docker_image.nginx.latest
#  name  = "tutorial"
#  ports {
#    internal = 80
#    external = 8000
#  }
#}


data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_launch_configuration" "aspen_cap_hello_world" {
  name_prefix     = "apen-cap-hello-world-"
  image_id        = data.aws_ami.amazon-linux.id
  instance_type   = "t2.micro"
  user_data       = file("user-data.sh")
  security_groups = [aws_security_group.aspen_cap_hello_world_instance.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "aspen_cap_hello" {
  name                 = "aspen-cap-hello-world"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.aspen_cap_hello_world.name
  vpc_zone_identifier  = module.vpc.public_subnets

  tag {
    key                 = "Name"
    value               = "HashiCorp Learn ASG - Terramino"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "aspen_cap_lb" {
  name = "aspen-cap-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}



resource "aws_lb" "aspen_cap_hello_world" {
  name               = "aspen-cap-hello-world-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.aspen_cap_lb.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "aspen_cap_hello_world" {
  load_balancer_arn = aws_lb.aspen_cap_hello_world.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aspen_cap_hello_world.arn
  }
}

resource "aws_lb_target_group" "aspen_cap_hello_world" {
  name     = "aspen-cap-hello-world"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_autoscaling_attachment" "aspen_cap_hello_world" {
  autoscaling_group_name = aws_autoscaling_group.aspen_cap_hello.id
  alb_target_group_arn   = aws_lb_target_group.aspen_cap_hello_world.arn
}

resource "aws_security_group" "aspen_cap_hello_world_instance" {
  name = "aspen-cap-hello-world"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.aspen_cap_lb.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.aspen_cap_lb.id]
  }

  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "aspen_cap_hello_world_lb" {
  name = "aspen-cap-hello-world-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}
