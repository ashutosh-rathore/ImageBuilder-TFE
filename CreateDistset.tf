
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
