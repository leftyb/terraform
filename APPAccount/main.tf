module "network" {
  source          = "./Network"
  cidr_block      = "172.17.0.0/16"
  az_count        = 3
  tags            = local.tags
}

resource "aws_ecs_cluster" "main" {
  name            = var.clusterName
  tags            = local.tags
}

module "ALB" {
  source             = "./ALB"
  tags               = local.tags
  app_port           = 81
  health_check_path  = "/ping.html"
  name               = local.web_tag.Product
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  internal           = false
  region             = data.aws_region.current.name
 }


module "app" {
  source             = "./app"
  tags               = local.tags
  name-ecs           = "app"
  app_image          = "${var.ci_cd_account_number}.dkr.ecr.eu-west-2.amazonaws.com/app"
  app_port           = 3000
  app_count          = 1
  fargate_cpu        = 1024
  fargate_memory     = 2048
  name               = "contoso"
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  region             = data.aws_region.current.name
  cluster_name       = "app"
  target_group_arn   = module.ALB.aws_alb_target_group
  security_group_elb_id  = module.ALB.security_group_elb_id
  vpc_range          = module.network.vpc_range
}