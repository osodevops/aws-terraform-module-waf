resource "aws_lambda_function" "SolutionHelper" {
  depends_on    = ["aws_iam_role.solution_helper_role"]
  function_name = "${var.account_name}-SolutionHelper"
  description   = "This lambda function executes generic common tasks to support this solution."
  role          = "${aws_iam_role.solution_helper_role.arn}"
  handler       = "log-parser.lambda_handler"

  runtime = "python2.7"
  timeout = "300"


  s3_bucket = "${join("-", list("solutions", data.aws_region.current.name))}"
  s3_key    = "library/solution-helper/v1/solution-helper.zip"

  tags = "${merge(var.common_tags,
    map("Name", "${var.environment}-${var.account_name}-WAF-lambda")
  )}"
}