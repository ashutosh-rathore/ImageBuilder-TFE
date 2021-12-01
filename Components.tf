/*
resource "aws_imagebuilder_component" "InstallCLI2" {
  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          //commands = ["sudo apt-get update"]
          commands = ["sudo apt-get install awscli"]
        }
        name      = "YamlCode"
        onFailure = "Continue"
      }]
    }]
    schemaVersion = 1.0
  })
  name     = "InstallCLI2"
  platform = "Linux"
  version  = "2.0.0"
}
*/

resource "aws_imagebuilder_component" "InstallCW2" {
  name     = "InstallCW2"
  platform = "Linux"
  uri      = "s3://arimagebuildcomponents/InstallCW2.yml"
  version  = "1.0.0"
  //kms_key_id = data.aws_kms_key.image_builder.arn

}


data "aws_imagebuilder_component" "InstallCLI" {
  //arn = "arn:aws:imagebuilder:us-east-2:aws:component/AnsiblePlay/1.0.0/1"
  arn = "arn:aws:imagebuilder:us-east-2:549987867165:component/installcli/1.0.0/1"
}

resource "aws_imagebuilder_component" "TestCLI" {
  data = yamlencode({
    phases = [{
      name = "test"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = ["aws --version"]
        }
        name      = "YamlCode"
        onFailure = "Continue"
      }]
    }]
    schemaVersion = 1.0
  })
  name     = "TestCLI"
  platform = "Linux"
  version  = "1.0.0"
}

resource "aws_imagebuilder_component" "Test_AWS_CW" {
  data = yamlencode({
    phases = [{
      name = "test"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = ["apt list --installed | grep '^amazon-cloudwatch-agent'"]
        }
        name      = "YamlCode"
        onFailure = "Continue"
      }]
    }]
    schemaVersion = 1.0
  })
  name     = "Test_AWS_CW"
  platform = "Linux"
  version  = "1.0.0"
}
