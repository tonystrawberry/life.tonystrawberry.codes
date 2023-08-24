module "ec2" {
  source = "./modules/ec2"

  instance_type = "t2.micro"
  project       = var.project
  subnet_id     = module.network.subnet_id
  security_group_id = module.network.security_group_id
}

module "identity" {
  source = "./modules/identity"

  project = var.project
}

module "network" {
  source = "./modules/network"

  project = var.project
}
