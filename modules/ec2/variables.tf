variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "life-tonystrawberry-codes"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance into"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to assign to the instance"
  type        = string
}
