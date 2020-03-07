variable "region" {
    description = "Which reigon to build the resources in"
}

variable "account_id" {
    description = "Which account we are deploying to"  
}

variable "deployed_at" {
  description = "The time that the API was deployed - this is used to force redeployements of the API"
  default = 0
}

