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

# The variable forcing seems to fix the issue of deploying an empty API but looks like 
# still need to look at the ordering of this:
#
# Error: Error creating API Gateway Deployment: BadRequestException: No integration defined for method
resource "aws_api_gateway_deployment" "subbox_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.subbox_api.id
  stage_name  = "prod"

  variables = {
    deployed_at = "${var.deployed_at}"
    methods = "${join(",", var.wait_for)}"
  }
}