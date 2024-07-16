resource "aws_iam_role" "lambda_access_role" {
  name = "${var.base_name}_lambda_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = ["lambda.amazonaws.com", "events.amazonaws.com"],
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_access_policy" {
  name        = "${var.base_name}_lambda_access_policy"
  description = "Provides required access to Lambda"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "dynamodb:*",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_access_attachment" {
  policy_arn = aws_iam_policy.lambda_access_policy.arn
  role       = aws_iam_role.lambda_access_role.name
}