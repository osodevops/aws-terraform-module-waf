resource "aws_iam_role_policy" "lambda_role_custom_resource_s3_access" {
  name = "${var.account_name}-lambda_role_custom_resourceS3Access"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:CreateBucket",
                "s3:GetBucketLocation",
                "s3:GetBucketNotification",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:PutBucketNotification"
            ],
            "Resource": "arn:aws:s3:::${var.s3_access_log_bucket}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_custom_resource_lambda_access" {
  count = "${local.is_reputation_lists_protection_activated}"
  name = "${var.account_name}-lambda_role_custom_resourceLambdaAccess"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "${aws_lambda_function.lambda_waf_reputation_lists_parser_function.arn}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_custom_resource_waf_access" {
  name = "${var.account_name}-lambda_role_custom_resourceWAFAccess"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "waf-regional:GetWebACL",
                "waf-regional:UpdateWebACL"
              ],
            "Resource": "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:webacl/${aws_wafregional_web_acl.waf_web_acl.id}"
        }
    ]
}
EOF
}



resource "aws_iam_role_policy" "lambda_role_custom_resource_waf_rule_access" {
  name = "${var.account_name}-lambda_role_custom_resourceWAFRuleAccess"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "waf-regional:GetRule",
                "waf-regional:GetIPSet",
                "waf-regional:UpdateIPSet",
                "waf-regional:UpdateWebACL"
              ],
            "Resource": "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_custom_resource_waf_get_change_token" {
  name = "${var.account_name}-lambda_role_custom_resourceWAFGetChangeToken"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

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

resource "aws_iam_role_policy" "lambda_role_custom_resource_logs_access" {
  name = "${var.account_name}-lambda_role_custom_resourceLogsAccess"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

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

resource "aws_iam_role_policy" "lambda_role_custom_resource_waf_ip_set_access" {
  name = "${var.account_name}-LambdaRoleCustomResource-WAFIPSetAccess"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

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
            "Resource": "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}::ipset/*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_custom_resource_waf_rate_based_rule_access" {
  name = "${var.account_name}-LambdaRoleCustomResource-WAFRateBasedRuleAccess"
  role = "${aws_iam_role.lambda_custom_resource_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "waf-regional:GetRateBasedRule",
                "waf-regional:CreateRateBasedRule",
                "waf-regional:DeleteRateBasedRule",
                "waf-regional:ListRateBasedRules",
                "waf-regional:UpdateWebACL"
              ],
            "Resource": "arn:aws:waf-regional:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:ratebasedrule/*"
        }
    ]
}
EOF
}