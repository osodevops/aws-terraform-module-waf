resource "aws_lambda_function" "lambda_waf_custom_resource_function" {
  depends_on    = ["aws_iam_role.lambda_custom_resource_role"]
  function_name = "${var.account_name}-LambdaWAFCustomResourceFunction"
  description   = "This lambda function configures the Web ACL rules based on the features enabled in TFVARS"
  role          = "${aws_iam_role.lambda_custom_resource_role.arn}"
  handler       = "custom-resource.lambda_handler"
  runtime       = "python2.7"
  memory_size   = "128"
  timeout       = "300"


  s3_bucket = "${join("-", list("solutions", data.aws_region))}"
  s3_key    = "aws-waf-security-automations/v4/custom-resource.zip"

  tags = "${merge(var.common_tags,
    map("Name", "${var.environment}-${var.account_name}-WAF-lambda")
  )}"
}