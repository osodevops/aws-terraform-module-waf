resource "aws_iam_role" "lambda_role_reputation_lists_parser" {
  count = "${local.ReputationListsProtectionActivated}"
  name = "${upper(var.common_tags["Environment"])}-LAMBDA-REPUTATION-LISTS-ROLE"

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