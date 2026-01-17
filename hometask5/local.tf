locals {
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  name_prefix = "${var.env}-hometask5"

  common_tags = merge(var.tags, { Env = var.env })
}
