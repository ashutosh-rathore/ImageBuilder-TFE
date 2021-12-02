#Creating pipeline

resource "aws_imagebuilder_image_pipeline" "NewPipe2-TFE" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.NewRecipe2-TFE.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.NewConfig2-TFE.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.NewDistSet2-TFE.arn
  name                             = var.PipelineName
  status                           = "ENABLED"
  description                      = "Pipeline to create AMI"

  depends_on = [
    aws_imagebuilder_image_recipe.NewRecipe2-TFE,
    aws_imagebuilder_infrastructure_configuration.NewConfig2-TFE
  ]

}

#Defining Infrastructe Configurations


resource "aws_imagebuilder_infrastructure_configuration" "NewConfig2-TFE" {
  description                   = "Configuration for Pipeline"
  instance_profile_name         = aws_iam_instance_profile.AttachToPipe.name
  instance_types                = ["t2.micro"]
  name                          = var.InfraName
  security_group_ids            = [data.aws_security_group.SG.id]
  subnet_id                     = data.aws_subnet.SN.id
  terminate_instance_on_failure = true

}


#Define Distribution Settings

resource "aws_imagebuilder_distribution_configuration" "NewDistSet2-TFE" {
  name = var.DistSetName

  distribution {
    ami_distribution_configuration {
      name = "AR-Ubuntu-{{ imagebuilder:buildDate }}"
      launch_permission {
        user_ids = ["549987867165"]
      }
    }
    region = var.aws_region
  }
}

#Recipe for Ubuntu 20

resource "aws_imagebuilder_image_recipe" "NewRecipe2-TFE" {
  name         = var.RecipeName
  parent_image = "arn:${data.aws_partition.current.partition}:imagebuilder:${data.aws_region.current.name}:aws:image/ubuntu-server-20-lts-x86/x.x.x"
  version      = var.Version
  description  = "Creating Recipe through TFE"

  // Below cron is for every first day of month at 10PM CST, but for now will run it manually
  /*
schedule {
    schedule_expression = "cron(0 4 1 * ? *)"
  }
*/

  block_device_mapping {
    device_name = "/dev/xvdb"

    ebs {
      delete_on_termination = true
      volume_size           = 10
      volume_type           = "gp2"
    }
  }
  component {
    //component_arn = data.aws_imagebuilder_component.AnsiblePlay.arn
    component_arn = aws_imagebuilder_component.InstallCW2.arn
  }
  component {
    component_arn = data.aws_imagebuilder_component.InstallCLI.arn
  }
  component {
    component_arn = aws_imagebuilder_component.Test_AWS_CW.arn
  }
  component {
    component_arn = aws_imagebuilder_component.TestCLI.arn
  }
}

#Components

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