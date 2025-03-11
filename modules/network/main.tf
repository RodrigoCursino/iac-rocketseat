#VPC
resource "aws_vpc" "desafio_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.name}-vpc"
    IAC  = true
  }
}

#Internet Gateway
resource "aws_internet_gateway" "desafio_igw" {
  vpc_id = aws_vpc.desafio_vpc.id

  tags = {
    Name = "${var.name}-igw"
    IAC  = true
  }
}

#tabela de rotas
resource "aws_route_table" "desafio_public_rt" {
  vpc_id = aws_vpc.desafio_vpc.id

  tags = {
    Name = "${var.name}-route"
    IAC  = true
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.desafio_igw.id
  }
}

#Subnets
resource "aws_subnet" "subnet_desafio_um" {
  vpc_id            = aws_vpc.desafio_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone_um

  tags = {
    Name = "${var.name}-subnet-um"
    IAC  = true
  }

  # depends_on = [
  #   aws_vpc.desafio_vpc
  # ]
}

resource "aws_subnet" "subnet_desafio_dois" {
  vpc_id            = aws_vpc.desafio_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone_dois

  tags = {
    Name = "${var.name}-subnet-dois"
    IAC  = true
  }

  # depends_on = [
  #   aws_vpc.desafio_vpc
  # ]
}

# Associar uma rota a uma subnet
resource "aws_route_table_association" "subnet_um_association" {
  subnet_id      = aws_subnet.subnet_desafio_um.id
  route_table_id = aws_route_table.desafio_public_rt.id
}

resource "aws_route_table_association" "subnet_dois_association" {
  subnet_id      = aws_subnet.subnet_desafio_dois.id
  route_table_id = aws_route_table.desafio_public_rt.id
}

#security Group LOAD Balancer
resource "aws_security_group" "desafio_sg_lb" {
  name   = "desafio-sg-lb"
  vpc_id = aws_vpc.desafio_vpc.id

  tags = {
    Name = "${var.name}-sg_lb"
    IAC  = true
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso da internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Security Group Instance
resource "aws_security_group" "desafio_sg_instance" {
  vpc_id = aws_vpc.desafio_vpc.id

  tags = {
    Name = "${var.name}-sg_instance"
    IAC  = true
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.desafio_sg_lb.id] # Apenas Load Balancer pode acessar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



