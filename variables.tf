variable "aws_region" {
  description = "AWS Region to deploy to"
  default     = "us-west-2"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs in given region"
  default     = "2"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "EcsTaskExecutionRole"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  # default     = "mmumshad/simple-webapp:latest"
  default     = "jameswwirth/samplewebsite:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of containers to run"
  default     = 3
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  default     = "256"
}

variable "fargate_memory" {
  default     = "512"
}

variable "lb_port" {
  description = "Load Balancer port"
  default     = 80
}

variable "cpu_threshold_high" {
  default     = 85
}

variable "cpu_threshold_low" {
  default     = 40
}

variable "memory_threshold_high" {
  default     = 85
}

variable "memory_threshold_low" {
  default     = 30
}