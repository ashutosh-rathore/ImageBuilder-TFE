
resource "aws_imagebuilder_infrastructure_configuration" "NewConfig2-TFE" {
  description                   = "Configuration for Pipeline"
  instance_profile_name         = aws_iam_instance_profile.AttachToPipe.name
  instance_types                = ["t2.micro"]
  name                          = var.InfraName
  security_group_ids            = [data.aws_security_group.SG.id]
  subnet_id                     = data.aws_subnet.SN.id
  terminate_instance_on_failure = true

}