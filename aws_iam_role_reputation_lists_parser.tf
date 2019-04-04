resource "aws_iam_role" "lambda_role_reputation_lists_parser" {
  count = "${local.is_reputation_lists_protection_activated}"
  name = "${upper(var.environment)}-LAMBDA-REPUTATION-LISTS-ROLE"

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