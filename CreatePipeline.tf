#Create IAM role first
#Create pipeline then
#Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image_pipeline#schedule

resource "aws_imagebuilder_image_pipeline" "NewPipe-TFE" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.NewRecipe-TFE.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.NewConfig-TFE.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.NewDistSet-TFE.arn
  name        = "ImageBuilderPipeline-TFE"
  status      = "ENABLED"
  description = "Pipeline to create AMI"

  depends_on = [
    aws_imagebuilder_image_recipe.NewRecipe-TFE,
    aws_imagebuilder_infrastructure_configuration.NewConfig-TFE
  ]

}