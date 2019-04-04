resource "aws_cloudwatch_event_rule" "lambda_waf_reputation_lists_parser_events_rule" {
  count               = "${local.ReputationListsProtectionActivated}"
  depends_on          = ["aws_lambda_function.lambda_waf_reputation_lists_parser_function", "aws_wafregional_ipset.waf_reputation_lists_set1", "aws_wafregional_ipset.waf_reputation_lists_set2"]
  name                = "${upper(var.environment)}-LAMBDA-WAF-REPUTATION-LIST-PARSER-EVENTS-RULE"
  description         = "OSO DevOps - WAF Reputation Lists"
  schedule_expression = "rate(1 hour)"
}
