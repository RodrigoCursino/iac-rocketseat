module "network" {

  availability_zone_um   = var.availability_zone_um
  availability_zone_dois = var.availability_zone_dois
  name                   = var.name
  source                 = "./modules/network"
}

module "ec2" {

  source = "./modules/ec2"
  ami    = var.ami
  name   = var.name

  subnet_id_um      = module.network.subnet_id_um
  subnet_id_dois    = module.network.subnet_id_dois
  security_group_id = module.network.security_group_id_instance

  depends_on = [
    module.network
  ]
}

module "load_balance" {

  source = "./modules/load_balance"
  port   = var.port
  name   = var.name

  vpc_id            = module.network.vpc_id
  subnet_id_um      = module.network.subnet_id_um
  subnet_id_dois    = module.network.subnet_id_dois
  instance_um_id    = module.ec2.instance_um_id
  instance_dois_id  = module.ec2.instance_dois_id
  security_group_id = module.network.security_group_id_lg

  depends_on = [
    module.ec2
  ]
}