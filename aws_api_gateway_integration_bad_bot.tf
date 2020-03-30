resource "aws_api_gateway_integration" "api_gateway_badbot_method_root_integration" {
  count = local.is_badbot_protection_activated
  depends_on = [
    aws_api_gateway_rest_api.api_gateway_badbot,
    aws_api_gateway_method.api_gateway_badbot_method,
    aws_lambda_function.lambda_waf_badbot_parser_function,
  ]
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_badbot[0].id
  resource_id             = aws_api_gateway_rest_api.api_gateway_badbot[0].root_resource_id
  http_method             = aws_api_gateway_method.api_gateway_badbot_method_root[0].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_waf_badbot_parser_function[0].arn}/invocations"
}

resource "aws_api_gateway_integration" "api_gateway_badbot_method_integration" {
  count = local.is_badbot_protection_activated
  depends_on = [
    aws_api_gateway_rest_api.api_gateway_badbot,
    aws_api_gateway_resource.api_gateway_badbot_resource,
    aws_api_gateway_method.api_gateway_badbot_method,
    aws_lambda_function.lambda_waf_badbot_parser_function,
  ]
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_badbot[0].id
  resource_id             = aws_api_gateway_resource.api_gateway_badbot_resource[0].id
  http_method             = aws_api_gateway_method.api_gateway_badbot_method[0].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_waf_badbot_parser_function[0].arn}/invocations"
}

