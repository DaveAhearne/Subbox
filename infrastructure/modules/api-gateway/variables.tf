variable "deployed_at" {
  description = "The time that the API was deployed - this is used to force redeployements of the API"
}

variable "wait_for" {
    type = list
    default = []
    description = "The endpoints to wait to be completed on before attempting deployment - fixes an issue with attempting to deploy an API without any methods"
}
