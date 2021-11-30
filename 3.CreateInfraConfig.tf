#ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_infrastructure_configuration#key_pair

resource "aws_imagebuilder_infrastructure_configuration" "NewConfig-TFE" {
  description                   = "Configuration for Pipeline"
  instance_profile_name         = aws_iam_instance_profile.AttachToPipe.name
  instance_types                = ["t2.micro"]
  name                          = "Infra-TFE"
  security_group_ids            = [data.aws_security_group.SG.id]
  subnet_id                     = data.aws_subnet.SN.id
  terminate_instance_on_failure = true

}