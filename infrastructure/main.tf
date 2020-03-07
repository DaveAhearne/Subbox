provider "aws" {
  profile = "default"
  region  = var.region
}

module "create_api" {
  source = "./modules/api"
}

module "get_all_submissions" {
  source      = "./modules/endpoint"
  account_id  = var.account_id
  region      = var.region
  deployed_at = var.deployed_at

  lambda_name = "get_all_submissions"
  http_method = "GET"

  api_gateway_id          = module.create_api.api_gateway_id
  api_gateway_resource_id = module.create_api.api_gateway_submission_endpoint
}