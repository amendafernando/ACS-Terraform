module "alb" {
  source      = "../../modules/alb"
  env         = "prod"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
}
