provider "aws" {
  profile = "default"
  region  = var.region
}

module "create_api" {
  source = "./modules/api-gateway"
  deployed_at = var.deployed_at
  wait_for = [ module.get_all_submissions.gateway_method, module.store_submission.gateway_method ]
}

module "create_website" {
  source = "./modules/website"
  website_bucket_name = "2020-subbox-website-deploy-bucket-dsa"
  path_to_folder = "../ui/build"
}

module "get_all_submissions" {
  source      = "./modules/endpoint"
  
  account_id  = var.account_id
  region      = var.region

  lambda_name = "get_all_submissions"
  http_method = "GET"

  api_gateway_id          = module.create_api.api_gateway_id
  api_gateway_resource_id = module.create_api.api_gateway_submission_endpoint
}

module "store_submission" {
  source      = "./modules/endpoint"
  
  account_id  = var.account_id
  region      = var.region

  lambda_name = "store_submission"
  http_method = "POST"

  api_gateway_id          = module.create_api.api_gateway_id
  api_gateway_resource_id = module.create_api.api_gateway_submission_endpoint
}