#ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image_recipe#parent_image

/* this is still on testing to directly create AMI
resource "aws_imagebuilder_image" "NewImage-TFE" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.NewRecipe-TFE.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.NewConfig-TFE.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.NewDistSet-TFE.arn


  depends_on = [
    aws_imagebuilder_image_recipe.NewRecipe-TFE,
    aws_imagebuilder_distribution_configuration.NewDistSet-TFE,
    aws_imagebuilder_infrastructure_configuration.NewConfig-TFE
  ]
}*/

resource "aws_imagebuilder_image_recipe" "NewRecipe-TFE" {
  name         = "UbuntuRecipe"
  parent_image = "arn:${data.aws_partition.current.partition}:imagebuilder:${data.aws_region.current.name}:aws:image/ubuntu-server-20-lts-x86/x.x.x"
  version      = "1.0.0"
  description  = "Creating Recipe through TFE"


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



/*
resource "aws_imagebuilder_component" "Test1" {
  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = ["echo 'hello AR world'"]
        }
        name      = "YamlCode"
        onFailure = "Continue"
      }]
    }]
    schemaVersion = 1.0
  })
  name     = "HelloComponent"
  platform = "Linux"
  version  = "1.0.0"
}*/
