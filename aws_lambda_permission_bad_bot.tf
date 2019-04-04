resource "aws_lambda_permission" "lambda_invoke_badbot_permission" {
  count         = "${local.is_badbot_protection_activated}"
  depends_on    = ["aws_lambda_function.lambda_waf_badbot_parser_function"]
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:*"
  function_name = "${aws_lambda_function.lambda_waf_badbot_parser_function.arn}"
  principal     = "apigateway.amazonaws.com"
}
