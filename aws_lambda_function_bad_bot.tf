resource "aws_lambda_function" "lambda_waf_badbot_parser_function" {
  count         = "${local.BadBotProtectionActivated}"
  depends_on    = ["aws_iam_role.lambda_badbot_role"]
  function_name = "${var.account_name}-lambda_waf_badbot_parser_function"
  description   = "This lambda function will intercepts and inspects trap endpoint requests to extract its IP address, and then add it to an AWS WAF block list."
  role          = "${aws_iam_role.lambda_badbot_role.arn}"
  handler       = "access-handler.lambda_handler"
  runtime       = "python2.7"
  memory_size   = "128"
  timeout       = "300"

  s3_bucket = "${join("-", list("solutions", data.aws_region))}"
  s3_key        = "aws-waf-security-automations/v2/access-handler.zip"

  environment {
    variables = {
      ActivateBadBotProtectionParam          = "${var.ActivateBadBotProtectionParam}"
      ActivateHttpFloodProtectionParam       = "${var.ActivateHttpFloodProtectionParam}"
      ActivateReputationListsProtectionParam = "${var.ActivateReputationListsProtectionParam}"
      ActivateScansProbesProtectionParam     = "${var.ActivateScansProbesProtectionParam}"
      CrossSiteScriptingProtectionParam      = "${var.CrossSiteScriptingProtectionParam}"
      SqlInjectionProtectionParam            = "${var.SqlInjectionProtectionParam}"
      ErrorThreshold                         = "${var.ErrorThreshold}"
      RequestThreshold                       = "${var.RequestThreshold}"
      WAFBlockPeriod                         = "${var.WAFBlockPeriod}"
      IP_SET_ID_BAD_BOT                           = "${aws_wafregional_ipset.waf_badbot_set.id}"
      REGION                                = "${data.aws_region}"
      SEND_ANONYMOUS_USAGE_DATA                 = "${var.SendAnonymousUsageData}"
      UUID                                   = "${random_string.UniqueID.result}"
      LOG_TYPE                  = "alb"
    }
  }

  tags = "${merge(var.common_tags,
    map("Name", "${var.environment}-${var.account_name}-WAF-LAMBDA")
  )}"
}