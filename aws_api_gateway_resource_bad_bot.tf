resource "aws_api_gateway_resource" "api_gateway_badbot_resource" {
  count       = local.is_badbot_protection_activated
  rest_api_id = aws_api_gateway_rest_api.api_gateway_badbot[0].id
  parent_id   = aws_api_gateway_rest_api.api_gateway_badbot[0].root_resource_id
  path_part   = "{proxy+}"
}

