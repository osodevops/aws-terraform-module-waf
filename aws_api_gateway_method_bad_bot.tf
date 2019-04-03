resource "aws_api_gateway_method" "api_gateway_badbot_method" {
  count         = "${local.BadBotProtectionActivated}"
  depends_on    = ["aws_lambda_function.lambda_waf_badbot_parser_function", "aws_lambda_permission.lambda_invoke_permission_badbot", "aws_api_gateway_rest_api.api_gateway_badbot"]
  rest_api_id   = "${aws_api_gateway_rest_api.api_gateway_badbot.id}"
  resource_id   = "${aws_api_gateway_resource.api_gateway_badbot_resource.id}"
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.X-Forwarded-For" = false
  }
}
