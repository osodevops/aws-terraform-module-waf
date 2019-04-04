resource "aws_lambda_function" "lambda_waf_log_parser_function" {
  count         = "${local.is_log_parser_activated}"
  depends_on    = ["aws_iam_role.lambda_log_parser_role", "aws_wafregional_ipset.waf_blacklist_set", "aws_wafregional_ipset.waf_scans_probes_set", "aws_wafregional_ipset.waf_http_flood_set"]
  function_name = "${var.account_name}-LambdaWAFLogParserFunction"
  description   = "This function parses ALB access logs to identify suspicious behavior, such as an abnormal amount of errors. It then blocks those IP addresses for a customer-defined period of time. Parameters: ${var.waf_badbot_error_threshold} ${var.waf_block_period}"
  role          = "${aws_iam_role.lambda_log_parser_role.arn}"
  handler       = "log-parser.lambda_handler"
  runtime     = "python2.7"
  memory_size = "512"
  timeout     = "300"

  s3_bucket     = "${join("-", list("solutions", data.aws_region.current.name))}"
  s3_key        = "aws-waf-security-automations/v2/log-parser.zip"

  environment {
    variables = {
      OUTPUT_BUCKET                                  = "${var.s3_access_log_bucket}"
      IP_SET_ID_BLACKLIST                            = "${aws_wafregional_ipset.waf_blacklist_set.id}"
      IP_SET_ID_AUTO_BLOCK                           = "${aws_wafregional_ipset.waf_scans_probes_set.id}"
      IP_SET_ID_HTTP_FLOOD                           = "${aws_wafregional_ipset.waf_http_flood_set.id}"
      BLACKLIST_BLOCK_PERIOD                         = "${var.waf_block_period}"
      ERROR_PER_MINUTE_LIMIT                         = "${var.waf_badbot_error_threshold}"
      SEND_ANONYMOUS_USAGE_DATA                      = "${var.send_anonymous_usage_data_to_aws}"
      UUID                                           = "${random_string.UniqueID.result}"
      LIMIT_IP_ADDRESS_RANGES_PER_IP_MATCH_CONDITION = "10000"
      MAX_AGE_TO_UPDATE                              = "30"
      REGION                                         = "${data.aws_region.current.name}"
      LOG_TYPE                                       = "alb"
    }
  }

  tags = "${merge(var.common_tags,
    map("Name", "${var.environment}-${var.account_name}-WAF-lambda")
  )}"
}