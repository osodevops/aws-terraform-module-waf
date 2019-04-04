resource "aws_api_gateway_integration" "api_gateway_badbot_method_root_integration" {
  count                   = "${local.is_badbot_protection_activated}"
  depends_on              = ["aws_api_gateway_rest_api.api_gateway_badbot","aws_api_gateway_method.api_gateway_badbot_method", "aws_lambda_function.lambda_waf_badbot_parser_function"]
  rest_api_id             = "${aws_api_gateway_rest_api.api_gateway_badbot.id}"
  resource_id             = "${aws_api_gateway_rest_api.api_gateway_badbot.root_resource_id}"
  http_method             = "${aws_api_gateway_method.api_gateway_badbot_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_waf_badbot_parser_function.arn}/invocations"
}

resource "aws_api_gateway_integration" "api_gateway_badbot_method_integration" {
  count                   = "${local.is_badbot_protection_activated}"
  depends_on              = ["aws_api_gateway_rest_api.api_gateway_badbot", "aws_api_gateway_resource.api_gateway_badbot_resource", "aws_api_gateway_method.api_gateway_badbot_method", "aws_lambda_function.lambda_waf_badbot_parser_function"]
  rest_api_id             = "${aws_api_gateway_rest_api.api_gateway_badbot.id}"
  resource_id             = "${aws_api_gateway_resource.api_gateway_badbot_resource.id}"
  http_method             = "${aws_api_gateway_method.api_gateway_badbot_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_waf_badbot_parser_function.arn}/invocations"
}