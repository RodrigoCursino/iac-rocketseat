output "subnet_id_um" {
  value = aws_subnet.subnet_desafio_um.id
}

output "subnet_id_dois" {
  value = aws_subnet.subnet_desafio_dois.id
}

output "vpc_id" {
  value = aws_vpc.desafio_vpc.id
}

output "security_group_id_instance" {
  value = aws_security_group.desafio_sg_instance.id
}

output "security_group_id_lg" {
  value = aws_security_group.desafio_sg_lb.id
}