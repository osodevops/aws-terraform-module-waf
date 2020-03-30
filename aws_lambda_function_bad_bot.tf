resource "aws_lambda_function" "lambda_waf_badbot_parser_function" {
  count         = local.is_badbot_protection_activated
  depends_on    = [aws_iam_role.lambda_badbot_role]
  function_name = "${var.account_name}-lambda_waf_badbot_parser_function"
  description   = "This lambda function will intercepts and inspects trap endpoint requests to extract its IP address, and then add it to an AWS WAF block list."
  role          = aws_iam_role.lambda_badbot_role[0].arn
  handler       = "access-handler.lambda_handler"
  runtime       = "python2.7"
  memory_size   = "128"
  timeout       = "300"

  s3_bucket = join("-", ["solutions", data.aws_region.current.name])
  s3_key    = "aws-waf-security-automations/v2/access-handler.zip"

  environment {
    variables = {
      activate_badbot_protection_param           = var.activate_badbot_protection_param
      activate_http_flood_protection_param       = var.activate_http_flood_protection_param
      activate_reputation_lists_protection_param = var.activate_reputation_lists_protection_param
      activate_scans_probes_protection_param     = var.activate_scans_probes_protection_param
      cross_site_scripting_protection_param      = var.cross_site_scripting_protection_param
      sql_injection_protection_param             = var.sql_injection_protection_param
      waf_badbot_error_threshold                 = var.waf_badbot_error_threshold
      waf_badbot_request_threshold               = var.waf_badbot_request_threshold
      waf_block_period                           = var.waf_block_period
      IP_SET_ID_BAD_BOT                          = aws_wafregional_ipset.waf_badbot_set[0].id
      REGION                                     = data.aws_region.current.name
      SEND_ANONYMOUS_USAGE_DATA                  = var.send_anonymous_usage_data_to_aws
      UUID                                       = random_string.UniqueID.result
      LOG_TYPE                                   = "alb"
    }
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${var.environment}-${var.account_name}-WAF-LAMBDA"
    },
  )
}

