provider "aws" {
  profile = "default"
  region  = var.region
}

locals {
  table_name = "PostData"
}

module "create_api" {
  source      = "./modules/api-gateway"
}

module "create_website" {
  source              = "./modules/website"
  website_bucket_name = "2020-subbox-website-deploy-bucket-dsa"
  path_to_folder      = "../ui/build"
  deployed_at = var.deployed_at
}

module "post_storage" {
  source = "./modules/storage"
  table_name = local.table_name
}

module "get_all_submissions" {
  source = "./modules/endpoint"

  account_id = var.account_id
  region     = var.region

  lambda_name = "get_all_submissions"
  http_method = "GET"

  api_gateway_id          = module.create_api.api_gateway_id
  api_gateway_resource_id = module.create_api.api_gateway_submission_id

  environment_variables = {
    table_arn = module.post_storage.table_arn
    table_name = local.table_name
    region    = var.region
  }
}

module "store_submission" {
  source = "./modules/endpoint"

  account_id = var.account_id
  region     = var.region

  lambda_name = "store_submission"
  http_method = "POST"

  api_gateway_id          = module.create_api.api_gateway_id
  api_gateway_resource_id = module.create_api.api_gateway_submission_id

  environment_variables = {
    table_arn = module.post_storage.table_arn
    table_name = local.table_name
    region    = var.region
  }
}

resource "aws_api_gateway_deployment" "subbox_api_deployment" {
  rest_api_id = module.create_api.api_gateway_id
  stage_name  = "prod"
  depends_on = [module.get_all_submissions.integration, module.store_submission.integration]

  variables = {
    deployed_at = "${var.deployed_at}"
  }
}