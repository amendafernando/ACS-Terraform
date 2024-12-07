module "webservers" {
  source             = "../../modules/webservers"
  env                = "dev"
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids         = data.terraform_remote_state.network.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  ami_id             = "ami-0453ec754f44f9a4a"
  instance_type      = "t2.micro"
  key_name           = "my-key"  
  associate_public_ip = true
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
}
