# SG to allow traffic from public to port 80 for web traffic
resource "aws_security_group" "lb" {
  name        = "loadbalancer-security-group"
  description = "controls access to the loadbalancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow traffic from the ALB to the ECS cluster running on differnt ports
resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-security-group"
  description = "allow inbound access from the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port 
    to_port         = var.app_port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

