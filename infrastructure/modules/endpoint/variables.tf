variable "region" {
    description = "Which reigon to build the resources in"
}

variable "account_id" {
    description = "Which account we are deploying to"  
}

variable "api_gateway_resource_id" {
    description = "The id of the method to attach to"
}

variable "api_gateway_id" {
    description = "The api gateway to attach to"
}

variable "lambda_name" {
    description = "The name of the lambda - the path will be inferred from convention"
}

variable "http_method" {
    description = "Which HTTP method to use e.g. GET, POST, PUT etc."
}

variable "deployed_at" {
  description = "The time that the API was deployed - this is used to force redeployements of the API"
}
