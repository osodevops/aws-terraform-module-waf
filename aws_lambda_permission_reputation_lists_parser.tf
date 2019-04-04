resource "aws_lambda_permission" "lambda_invoke_reputation_lists_parser_permission" {
  count         = "${local.is_reputation_lists_protection_activated}"
  depends_on    = ["aws_lambda_function.lambda_waf_reputation_lists_parser_function", "aws_cloudwatch_event_rule.lambda_waf_reputation_lists_parser_events_rule"]
  function_name = "${aws_lambda_function.lambda_waf_reputation_lists_parser_function.arn}"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  statement_id  = "AllowExecutionFromCloudWatch"
  source_arn    = "${aws_cloudwatch_event_rule.lambda_waf_reputation_lists_parser_events_rule.arn}"
}
