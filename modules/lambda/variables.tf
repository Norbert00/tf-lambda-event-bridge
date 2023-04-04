variable "m_statement_id" {
  type = string
}

variable "m_action" {
  type = string
}

variable "m_principal" {
  type = string
}

variable "m_source_arn" {
  type = string
}

variable "m_lambda_function_name" {
  type = string
}

variable "m_role_arn" {
  type = string
}

variable "m_handler" {
  type = string
}

variable "m_runtime" {
  type = string

  default = "python3.8"
}

variable "m_source_file" {
  type = string
}

variable "m_env_variables" {
  type = map(string)

  validation {
    condition     = endswith(var.m_env_variables.env_file_name, ".csv")
    error_message = "The tag file must be in .csv format"
  }

}
