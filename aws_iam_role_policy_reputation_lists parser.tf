resource "aws_iam_role_policy" "lambda_role_reputation_lists_parser_cloudwatch_logs" {
  count = "${local.is_reputation_lists_protection_activated}"
  name = "${var.account_name}-LambdaRoleReputationListsParserCloudWatchLogs"
  role = "${aws_iam_role.lambda_role_reputation_lists_parser.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:${data.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_reputation_lists_parser_waf_get_change_token" {
  count = "${local.is_reputation_lists_protection_activated}"
  name = "${var.account_name}-LambdaRoleReputationListsParserWAFGetChangeToken"
  role = "${aws_iam_role.lambda_role_reputation_lists_parser.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "waf-regional:GetChangeToken",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_reputation_lists_parser_waf_get_and_update_ip_set" {
  count = "${local.is_reputation_lists_protection_activated}"
  name = "${var.account_name}-LambdaRoleReputationListsParserWAFGetAndUpdateIPSet"
  role = "${aws_iam_role.lambda_role_reputation_lists_parser.id}"

 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "waf-regional:GetIPSet",
              "waf-regional:UpdateIPSet"
            ],
            "Resource": [
              "arn:aws:waf-regional:${data.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_reputation_lists_set1.id}",
              "arn:aws:waf-regional:${data.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_reputation_lists_set2.id}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_reputation_lists_parser_cloudwatch_access" {
  count = "${local.is_reputation_lists_protection_activated}"
  name = "${var.account_name}-LambdaRoleReputationListsParserCloudWatchAccess"
  role = "${aws_iam_role.lambda_role_reputation_lists_parser.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "cloudwatch:GetMetricStatistics",
            "Resource": "*"
        }
    ]
}
EOF
}