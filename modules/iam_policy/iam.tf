resource "aws_iam_policy" "iam_policy" {
  name        = var.m_name
  path        = var.m_path
  description = var.m_description
  policy      = data.aws_iam_policy_document.statement_map.json
}


data "aws_iam_policy_document" "statement_map" {
  dynamic "statement" {
    for_each = var.m_statement_map
    content {
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}
