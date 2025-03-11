variable "name" {
  type        = string
  description = "Nome da instancia EC2"
}

variable "ami" {
  type        = string
  description = "AMI da instancia EC2"
}

variable "subnet_id_um" {
  type        = string
  description = "ID da subrede um"
}

variable "subnet_id_dois" {
  type        = string
  description = "ID da subrede um"
}

variable "security_group_id" {
  type        = string
  description = "Id do security group"
}