resource "aws_iam_role" "lambda_log_parser_role" {
  count = "${local.LogParserActivated}"
  name = "${upper(var.common_tags["Environment"])}-LAMBDA-LOG-PARSER-ROLE"

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