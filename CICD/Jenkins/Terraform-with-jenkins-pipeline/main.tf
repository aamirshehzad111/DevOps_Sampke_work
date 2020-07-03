module "alb" {
  source                = "./module/application_loadbalancer"
  target-group_name     =  var.load_balancer_config["target-group_name"]
  subnets_id            =  var.load_balancer_config["subnets_id"]
  alb_sg                =  var.load_balancer_config["alb_sg"]
  vpc_id                =  var.load_balancer_config["vpc_id"]
}
