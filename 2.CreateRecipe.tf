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

  block_device_mapping {
    device_name = "/dev/xvdb"

    ebs {
      delete_on_termination = true
      volume_size           = 10
      volume_type           = "gp2"
    }
  }
  component {
    component_arn = aws_imagebuilder_component.HelloAR.arn
  }

  name         = "UbuntuRecipe"
  parent_image = "arn:${data.aws_partition.current.partition}:imagebuilder:${data.aws_region.current.name}:aws:image/ubuntu-server-20-lts-x86/x.x.x"
  version      = "1.0.0"
}


resource "aws_imagebuilder_component" "HelloAR" {
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
  name     = "TestingComponent"
  platform = "Linux"
  version  = "1.0.0"
}