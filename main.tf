resource "aws_lambda_function" "rds-lambda-stop-start" {
  filename         = "../functions/rds-lambda-stop-start.zip"
  function_name    = "rds-lambda-stop-start"
  role             = "${aws_iam_role.LambdaRDSManagement.arn}"
  handler          = "index.handler"
  timeout          = "5"
  runtime          = "nodejs6.10"
  source_code_hash = "${base64sha256(file("../functions/rds-lambda-stop-start.zip"))}"
}

resource "aws_iam_role" "LambdaRDSManagement" {
  name               = "LambdaRDSManagement"
  assume_role_policy = "${data.aws_iam_policy_document.LambdaRDSManagement.json}"
}

data "aws_iam_policy_document" "LambdaRDSManagement" {
  statement {
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com", "rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "RDSManagement" {
  name   = "RDSManagement"
  role   = "${aws_iam_role.LambdaRDSManagement.id}"
  policy = "${data.aws_iam_policy_document.RDSManagement.json}"
}

data "aws_iam_policy_document" "RDSManagement" {
  statement {
    effect = "Allow"

    actions = [
      "rds:StopDBInstance",
      "rds:StartDBInstance",
    ]

    resources = [
      "*",
    ]
  }
}
