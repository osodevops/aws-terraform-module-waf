resource "aws_iam_role_policy" "lambda_role_log_parser_s3_access" {
  count = local.is_log_parser_activated
  name  = "${upper(var.environment)}-LAMBDA-LOG-PARSER-S3-ACCESS-POLICY"
  role  = aws_iam_role.lambda_log_parser_role[0].id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::${var.s3_access_log_bucket}/*"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_role_log_parser_s3_access_put" {
  count = local.is_log_parser_activated
  name  = "${upper(var.environment)}-LAMBDA-LOG-PARSER-S3-ACCESS-PUT-POLICY"
  role  = aws_iam_role.lambda_log_parser_role[0].id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${var.s3_access_log_bucket}/aws-waf-security-automations-current-blocked-ips.json"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_role_log_parser_waf_get_change_token" {
  count = local.is_log_parser_activated
  name  = "${upper(var.environment)}-lambda_role_log_parserWAFGetChangeToken"
  role  = aws_iam_role.lambda_log_parser_role[0].id

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

resource "aws_iam_role_policy" "lambda_role_log_parser_waf_get_and_update_ip_set" {
  count = local.is_log_parser_activated
  name  = "${upper(var.environment)}-lambda_role_log_parserWAFGetAndUpdateIPSet"
  role  = aws_iam_role.lambda_log_parser_role[0].id

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
              "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_blacklist_set[0].id}",
              "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_scans_probes_set[0].id}",
              "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_http_flood_set[0].id}"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_role_log_parser_logs_access" {
  count = local.is_log_parser_activated
  name  = "${upper(var.environment)}-lambda_role_log_parserLogsAccess"
  role  = aws_iam_role.lambda_log_parser_role[0].id

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
            "Resource": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_role_log_parser_cloudwatch_access" {
  count = local.is_log_parser_activated
  name  = "${upper(var.environment)}-lambda_role_log_parserCloudWatchAccess"
  role  = aws_iam_role.lambda_log_parser_role[0].id

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

