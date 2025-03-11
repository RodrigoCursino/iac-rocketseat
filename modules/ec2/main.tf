resource "aws_instance" "desafio_instance_web_um" {
  ami             = var.ami
  subnet_id       = var.subnet_id_um
  instance_type   = "t2.micro"
  security_groups = [var.security_group_id]

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "<h1>Hello, World from EC2 with Terraform, Melissa!</h1>" | sudo tee /var/www/html/index.html
  EOF


  tags = {
    Name = "${var.name}-web-um-iac-${terraform.workspace}"
    IAC  = true
  }
}

resource "aws_instance" "desafio_instance_web_dois" {
  ami             = var.ami
  subnet_id       = var.subnet_id_dois
  instance_type   = "t2.micro"
  security_groups = [var.security_group_id]

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  suco systemctl enable httpd
  echo "<h1>Hello, World from EC2 with Terraform, Manu!</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    Name = "${var.name}-web-dois-iac-${terraform.workspace}"
    IAC  = true
  }
}

//
# Passo 1: Criar a configuração do Terraform
# Definir a VPC e sub-redes (se ainda não existir).
# Criar duas instâncias EC2 (pode usar Amazon Linux, Ubuntu, etc.).
# Criar um Security Group para permitir o tráfego entre o Load Balancer e as instâncias.
# Criar um Target Group e registrar as instâncias EC2 nele.
# Criar o Load Balancer e associá-lo ao Target Group.
# Criar um Listener para rotear as solicitações do Load Balancer para as instâncias.
# Código Terraform
# Aqui está um exemplo de código Terraform para configurar um Load Balancer entre duas instâncias EC2:

# 1. Criar a VPC e as Sub-redes
# hcl
# Copy
# Edit
# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "subnet_1" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
# }

# resource "aws_subnet" "subnet_2" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "us-east-1b"
# }
# 2. Criar o Security Group
# hcl
# Copy
# Edit
# resource "aws_security_group" "lb_sg" {
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# 3. Criar as Instâncias EC2
# h
# Copy
# Edit
# resource "aws_instance" "web_1" {
#   ami                    = "ami-12345678" # Substituir pelo AMI correto
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.subnet_1.id
#   security_groups        = [aws_security_group.lb_sg.name]
#   user_data              = <<-EOF
#               #!/bin/bash
#               echo "<h1>Instância 1</h1>" > /var/www/html/index.html
#               sudo yum install -y httpd
#               sudo systemctl start httpd
#               sudo systemctl enable httpd
#               EOF
# }

# resource "aws_instance" "web_2" {
#   ami                    = "ami-12345678"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.subnet_2.id
#   security_groups        = [aws_security_group.lb_sg.name]
#   user_data              = <<-EOF
#               #!/bin/bash
#               echo "<h1>Instância 2</h1>" > /var/www/html/index.html
#               sudo yum install -y httpd
#               sudo systemctl start httpd
#               sudo systemctl enable httpd
#               EOF
# }
# 4. Criar o Load Balancer
# hcl
# Copy
# Edit
# resource "aws_lb" "web_lb" {
#   name               = "web-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets           = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
# }
# 5. Criar o Target Group
# hcl
# Copy
# Edit
# resource "aws_lb_target_group" "web_tg" {
#   name     = "web-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id
# }

# resource "aws_lb_target_group_attachment" "web_1" {
#   target_group_arn = aws_lb_target_group.web_tg.arn
#   target_id        = aws_instance.web_1.id
#   port            = 80
# }

# resource "aws_lb_target_group_attachment" "web_2" {
#   target_group_arn = aws_lb_target_group.web_tg.arn
#   target_id        = aws_instance.web_2.id
#   port            = 80
# }
# 6. Criar um Listener para o Load Balancer
# hcl
# Copy
# Edit
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.web_lb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_tg.arn
#   }
# }
# Testando a Configuração
# Após aplicar o Terraform, você pode testar se o Load Balancer está funcionando corretamente.

# Aplique o Terraform:

# sh
# Copy
# Edit
# terraform init
# terraform apply -auto-approve
# Obtenha o DNS do Load Balancer:

# sh
# Copy
# Edit
# terraform output
# Ou vá até o AWS Console e procure o DNS name do Load Balancer na seção de Load Balancers.

# Acesse o Load Balancer no navegador:

# sh
# Copy
# Edit
# curl http://<DNS-DO-LOAD-BALANCER>
# Ou abra no navegador:

# pgsql
# Copy
# Edit
# http://<DNS-DO-LOAD-BALANCER>
# Você deverá ver alternadamente as mensagens "Instância 1" e "Instância 2", indicando que o balanceamento de carga está funcionando corretamente.

# Testar a alta disponibilidade:

# Desligue uma das instâncias EC2 via AWS Console e veja se o tráfego ainda funciona.
# Se o tráfego for distribuído corretamente para a instância restante, o Load Balancer está funcionando bem.
# Isso configurará um Load Balancer ALB na AWS distribuindo tráfego entre duas instâncias EC2, garantindo balanceamento e alta disponibilidade. 🚀
//