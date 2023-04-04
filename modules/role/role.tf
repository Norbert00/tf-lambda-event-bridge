resource "aws_iam_role" "tf_iam_role" {
  name               = var.m_name
  assume_role_policy = data.aws_iam_policy_document.tf_data_iam.json
}

resource "aws_iam_role_policy_attachment" "tf_iam_policy_attachment" {
  role       = aws_iam_role.tf_iam_role.name
  policy_arn = var.m_policy_arn
}

data "aws_iam_policy_document" "tf_data_iam" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    dynamic "principals" {
      for_each = var.m_principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
  }
}



