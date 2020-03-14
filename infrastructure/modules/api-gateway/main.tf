resource "aws_api_gateway_rest_api" "subbox_api" {
  name = "subbox_api"
  description = ""
}

resource "aws_api_gateway_resource" "base_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.subbox_api.id
  parent_id = aws_api_gateway_rest_api.subbox_api.root_resource_id
  path_part = "api"
}

resource "aws_api_gateway_resource" "submission" {
  rest_api_id = aws_api_gateway_rest_api.subbox_api.id
  parent_id = aws_api_gateway_resource.base_api_resource.id
  path_part = "submission"
}

# Should probably move this out of here when we do the other endpoint?
resource "aws_api_gateway_deployment" "subbox_api_deployment" {
  # depends_on = [ aws_api_gateway_integration.lambda_integration ]

  rest_api_id = aws_api_gateway_rest_api.subbox_api.id
  stage_name  = "prod"

  variables = {
    deployed_at = "${var.deployed_at}"
  }
}