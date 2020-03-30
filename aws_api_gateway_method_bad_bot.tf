resource "aws_api_gateway_method" "api_gateway_badbot_method" {
  count = local.is_badbot_protection_activated
  depends_on = [
    aws_lambda_function.lambda_waf_badbot_parser_function,
    aws_api_gateway_rest_api.api_gateway_badbot,
  ]
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_badbot[0].id
  resource_id   = aws_api_gateway_resource.api_gateway_badbot_resource[0].id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.X-Forwarded-For" = false
  }
}

resource "aws_api_gateway_method" "api_gateway_badbot_method_root" {
  count = local.is_badbot_protection_activated
  depends_on = [
    aws_lambda_function.lambda_waf_badbot_parser_function,
    aws_api_gateway_rest_api.api_gateway_badbot,
  ] #"aws_lambda_permission.LambdaInvokePermissionBadBot",
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_badbot[0].id
  resource_id   = aws_api_gateway_rest_api.api_gateway_badbot[0].root_resource_id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.X-Forwarded-For" = false
  }
}

