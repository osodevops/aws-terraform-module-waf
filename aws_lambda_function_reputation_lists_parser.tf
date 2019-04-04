resource "aws_lambda_function" "lambda_waf_reputation_lists_parser_function" {
  count         = "${local.is_reputation_lists_protection_activated}"
  depends_on    = ["aws_iam_role.lambda_role_reputation_lists_parser"]
  function_name = "${var.account_name}-lambda_waf_reputation_lists_parser_function"
  description   = "This lambda function checks third-party IP reputation lists hourly for new IP ranges to block. These lists include the Spamhaus Dont Route Or Peer (DROP) and Extended Drop (EDROP) lists, the Proofpoint Emerging Threats IP list, and the Tor exit node list."
  role          = "${aws_iam_role.lambda_role_reputation_lists_parser.arn}"
  handler       = "reputation-lists-parser.handler"
  runtime       = "nodejs6.10"
  memory_size   = "128"
  timeout       = "300"

  s3_bucket     = "${join("-", list("solutions", data.aws_region.current.name))}"
  s3_key        = "aws-waf-security-automations/v3/reputation-lists-parser.zip"

  environment {
    variables = {
      SEND_ANONYMOUS_USAGE_DATA = "${var.send_anonymous_usage_data_to_aws}"
      UUID                      = "${random_string.UniqueID.result}"
    }
  }

  tags = "${merge(var.common_tags,
    map("Name", "${var.environment}-${var.account_name}-WAF-lambda")
  )}"
}