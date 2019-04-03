resource "aws_iam_role" "lambda_custom_resource_role" {
  depends_on = ["aws_wafregional_web_acl.waf_web_acl"]
  name = "${upper(var.common_tags["Environment"])}-LAMBDA-CUSTOM-RESOURCE-ROLE"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}