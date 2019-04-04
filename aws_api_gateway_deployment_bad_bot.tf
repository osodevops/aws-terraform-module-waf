resource "aws_api_gateway_deployment" "api_gateway_badbot_deployment" {
  count      = "${local.is_badbot_protection_activated}"
  depends_on  = ["aws_api_gateway_method.api_gateway_badbot_method"]
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway_badbot.id}"
  stage_name  = "CFDeploymentStage"
  description = "CloudFormation Deployment Stage"
}

resource "aws_api_gateway_stage" "api_gateway_badbot_stage" {
  count      = "${local.is_badbot_protection_activated}"
  depends_on  = ["aws_api_gateway_deployment.api_gateway_badbot_deployment"]
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway_badbot.id}"
  deployment_id = "${aws_api_gateway_deployment.api_gateway_badbot_deployment.id}"
  stage_name  = "ProdStage"
  description = "Production Stage"
}