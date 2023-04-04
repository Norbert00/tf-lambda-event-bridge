output "lambda_name_output" {
  value = aws_lambda_function.tf-lambda.function_name
}

output "archive_file_output_path" {
  value = data.archive_file.init.output_path
}

output "lambda_arn" {
  value = aws_lambda_function.tf-lambda.arn
}
