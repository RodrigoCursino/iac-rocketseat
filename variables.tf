variable "ami" {
  description = "AMI usada para as instâncias EC2"
  type        = string
}

variable "name" {
  description = "Nome base para recursos"
  type        = string
}

variable "port" {
  description = "Porta usada pelo Load Balancer"
  type        = number
}

variable "availability_zone_um" {
  type        = string
  description = "Zona de Disponibilidade da Aplicação A"
}


variable "availability_zone_dois" {
  type        = string
  description = "Zona de Disponibilidade da Aplicação B"
}
