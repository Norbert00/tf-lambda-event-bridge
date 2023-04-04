variable "m_name" {
  type = string
  validation {
    condition     = startswith(var.m_name, "/aws/lambda/")
    error_message = "Cloudwatch logs must start from the path /aws/lambda/"
  }
}

variable "m_retention_in_days" {
  type = number
}
