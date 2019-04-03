resource "aws_api_gateway_rest_api" "api_gateway_badbot" {
  count       = "${local.BadBotProtectionActivated}"
  name        = "${var.environment}-WAF-BADBOT-API-GATEWAY"
  description = "API created by OSO DevOps. This endpoint will be used to capture bad bots."
}