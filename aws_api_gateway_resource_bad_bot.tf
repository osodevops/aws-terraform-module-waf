resource "aws_api_gateway_resource" "api_gateway_badbot_resource" {
  count       = "${local.BadBotProtectionActivated}"
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway_badbot.id}"
  parent_id   = "${aws_api_gateway_rest_api.api_gateway_badbot.root_resource_id}"
  path_part   = "{proxy+}"
}