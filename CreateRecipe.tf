
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
