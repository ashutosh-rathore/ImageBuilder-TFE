
resource "aws_imagebuilder_component" "InstallCW2" {
  name     = "InstallCW2"
  platform = "Linux"
  uri      = "s3://arimagebuildcomponents/InstallCW2.yml"
  version  = "1.0.0"
}


data "aws_imagebuilder_component" "InstallCLI" {
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