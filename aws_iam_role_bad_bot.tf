resource "aws_iam_role" "lambda_badbot_role" {
  count = local.is_badbot_protection_activated
  name  = "${upper(var.environment)}-LAMBDA-BADBOT-ROLE"

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

