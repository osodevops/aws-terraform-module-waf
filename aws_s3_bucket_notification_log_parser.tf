resource "aws_s3_bucket_notification" "lambda_waf_log_parser_s3_notification" {
  bucket = var.s3_access_log_bucket

  lambda_function {
    id                  = "${upper(var.environment)}-LAMBDA-WAF-LOG-PARSER-FUNCTION"
    lambda_function_arn = aws_lambda_function.lambda_waf_log_parser_function[0].arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = "gz"
  }
}

