output "api_gateway_id" {
    value = aws_api_gateway_rest_api.subbox_api.id
}

output "api_gateway_submission_endpoint" {
    value = aws_api_gateway_resource.submission.id
}