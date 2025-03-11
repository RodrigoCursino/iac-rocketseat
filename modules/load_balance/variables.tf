variable "name" {
  type        = string
  description = "Nome do projeto"
}

variable "vpc_id" {
  type        = string
  description = "Id da VPC"
}

variable "port" {
  type        = number
  default     = 80
  description = "Porta HTTP"
}

variable "instance_um_id" {
  type        = string
  description = "Id da instancia ec2 1"
}

variable "instance_dois_id" {
  type        = string
  description = "Id da instancia ec2 2"
}

variable "security_group_id" {
  type        = string
  description = "Id do security group"
}

variable "subnet_id_um" {
  type        = string
  description = "ID da subrede um"
}

variable "subnet_id_dois" {
  type        = string
  description = "ID da subrede um"
}
