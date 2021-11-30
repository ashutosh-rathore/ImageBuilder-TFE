
resource "aws_iam_instance_profile" "AttachToPipe" {
  name = "AttachToPipe"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "ForImageBuilderPipe"

  assume_role_policy = file("assumeRolePolicy.json")
}

resource "aws_iam_policy" "policy" {
  name        = "policyForImageBuild"
  description = "policy needs to be attached"
  policy      = file("Policy.json")
}

resource "aws_iam_role_policy_attachment" "Policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
