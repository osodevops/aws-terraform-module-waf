resource "aws_cloudwatch_event_target" "lambda_waf_reputation_lists_parser_events_rule_target" {
  depends_on = [aws_cloudwatch_event_rule.lambda_waf_reputation_lists_parser_events_rule]
  rule       = aws_cloudwatch_event_rule.lambda_waf_reputation_lists_parser_events_rule[0].name
  target_id  = aws_lambda_function.lambda_waf_reputation_lists_parser_function[0].id
  arn        = aws_lambda_function.lambda_waf_reputation_lists_parser_function[0].arn
  input      = <<EOF
{
  "lists": [
    {
      "url": "https://www.spamhaus.org/drop/drop.txt"
    },
    {
      "url": "https://check.torproject.org/exit-addresses",
      "prefix": "ExitAddress "
    },
    {
      "url": "https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt"
    }
  ],
  "logType": "alb",
  "region": "${data.aws_region.current.name}",
  "ipSetIds": [
    "${aws_wafregional_ipset.waf_reputation_lists_set1[0].id}",
    "${aws_wafregional_ipset.waf_reputation_lists_set2[0].id}"
  ]
}
EOF

}

