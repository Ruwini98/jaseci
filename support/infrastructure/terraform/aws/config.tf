locals {
  env           = terraform.workspace
  productprefix = "zsb"


  #BEGIN: Workspace Environments (index is based on workspace selected)
  environments = {
    "default"    = "Development"
    "production" = "Production"
  }

  envs = {
    "default"    = "dev"
    "production" = "prod"
  }

  accountids = {
    "default"    = var.development_aws_account_id
    # "production" = var.production_aws_account_id
  }
  #END: Workspace Environments

  #Local Variables 
  environment = lookup(local.environments, local.env)
  envprefix   = lookup(local.envs, local.env)
  envsuffix   = lookup(local.envs, local.env)
  accountid   = lookup(local.accountids, local.env)
  stdprefix   = "${local.productprefix}-${local.envprefix}"

  instance_type = t3.xlarge
  clusterversion = "1.22"

  #Boolean Variables
  isProd = local.env == "production" ? 1 : 0
  isDev  = local.env == "default" ? 1 : 0

  common_tags = tomap({
    "Product" =  var.product_name,
    "Environment" = local.environment,
    "Department"= upper(var.department),
    "CostCentre"= upper(var.cost_centre),
    "ProductOwner"= var.product_owner,
    "ProductManager"= var.product_manager,
    "PortfolioManager"= var.portfolio_manager,
    "ManagedBy"= var.managed_by}
  )

  provider_env_roles = {
    "default"    = var.development_aws_role_arn
    # "production" = var.production_aws_role_arn
  }
}
