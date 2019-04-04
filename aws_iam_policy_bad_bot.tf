resource "aws_iam_role_policy" "lambda_role_badbot_waf_get_change_token" {
  count = "${local.is_badbot_protection_activated}"
  name = "${upper(var.environment)}-lambda-badbot-waf-get-change-token-role"
  role = "${aws_iam_role.lambda_badbot_role.id}"

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

resource "aws_iam_role_policy" "lambda_role_badbot_waf_get_and_update_ip_set" {
  count = "${local.is_badbot_protection_activated}"
  name = "${upper(var.environment)}-lambda_role_badbot_waf_get_and_update_ip_set"
  role = "${aws_iam_role.lambda_badbot_role.id}"

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
            "Resource": "arn:aws:waf-regional:${data.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_badbot_set.id}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_badbot_role_logs_access" {
  count = "${local.is_badbot_protection_activated}"
  name = "${upper(var.environment)}-lambda_badbot_roleLogsAccess"
  role = "${aws_iam_role.lambda_badbot_role.id}"

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

resource "aws_iam_role_policy" "lambda_badbot_role_cloudwatch_access" {
  count = "${local.is_badbot_protection_activated}"
  name = "${upper(var.environment)}-lambda_badbot_roleCloudWatchAccess"
  role = "${aws_iam_role.lambda_badbot_role.id}"

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

