resource "aws_lambda_permission" "lambda_invoke_log_parser_permission" {
  count          = local.is_log_parser_activated
  depends_on     = [aws_lambda_function.lambda_waf_log_parser_function]
  statement_id   = "AllowExecutionFromS3Bucket"
  action         = "lambda:*"
  function_name  = aws_lambda_function.lambda_waf_log_parser_function[0].arn
  principal      = "s3.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
}

