variable "m_name" {
  type     = string
  nullable = false
}

variable "m_policy_arn" {
  type = string
}


variable "m_principals" {
  type = map(object({
    identifiers = set(string)
    type        = string
  }))
}
