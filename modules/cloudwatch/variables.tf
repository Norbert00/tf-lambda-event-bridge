variable "m_cloudwatch_event_bridge" {
  type = object({
    name        = string
    description = string
  })
  default = {
    name        = "tf-cloudwatch_event_bridge"
    description = "Add tag to ec2"

  }
}

variable "m_event_bridge_pattern" {
  type = string

  validation {
    condition     = endswith(var.m_event_bridge_pattern, ".json")
    error_message = "Cloudwatch Eventbridge pattern must be in .json format"
  }
}


variable "m_event_target" {
  type = string
}
