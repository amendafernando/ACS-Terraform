module "webservers" {
  source             = "../../modules/webservers"
  env                = "dev"
  vpc_id             = module.network.vpc_id
  subnet_ids         = [module.network.public_subnet_ids[0], module.network.private_subnet_ids[0]]
  ami_id             = "ami-0453ec754f44f9a4a" 
  instance_type      = "t2.micro"
  key_name           = "my-keypair"
  associate_public_ip = true
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
}
