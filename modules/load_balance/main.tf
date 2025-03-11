resource "aws_lb" "desafio_load_balance" {
  name               = "${var.name}-lb-${terraform.workspace}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_id_um, var.subnet_id_dois]
}

resource "aws_lb_target_group" "desafio_web_target" {
  name     = "${var.name}-target-${terraform.workspace}"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"   # Caminho para o health check (ajuste se necessário)
    interval            = 30    # Intervalo entre as verificações
    timeout             = 5     # Tempo limite para resposta
    healthy_threshold   = 3     # Número de sucessos para considerar a instância saudável
    unhealthy_threshold = 3     # Número de falhas para considerar a instância não saudável
    matcher             = "200" # Código de status HTTP esperado
  }
}

resource "aws_lb_target_group_attachment" "desafio_target_web_um" {
  target_group_arn = aws_lb_target_group.desafio_web_target.arn
  target_id        = var.instance_um_id
  port             = var.port

  depends_on = [
    aws_lb_target_group.desafio_web_target
  ]
}

resource "aws_lb_target_group_attachment" "desafio_target_web_dois" {
  target_group_arn = aws_lb_target_group.desafio_web_target.arn
  target_id        = var.instance_dois_id
  port             = var.port

  depends_on = [
    aws_lb_target_group.desafio_web_target
  ]
}

resource "aws_lb_listener" "desafio_load_balance_http_listener" {
  load_balancer_arn = aws_lb.desafio_load_balance.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.desafio_web_target.arn
  }
}