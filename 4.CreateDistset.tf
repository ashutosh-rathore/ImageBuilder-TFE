

#ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_distribution_configuration


resource "aws_imagebuilder_distribution_configuration" "NewDistSet-TFE" {
  name = "DistSet-TFE"

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
