variable "m_name" {
  type = string
}

variable "m_path" {
  type    = string
  default = "/"
}

variable "m_description" {
  type    = string
  default = ""
}
variable "m_statement_map" {
  type = map(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
}
