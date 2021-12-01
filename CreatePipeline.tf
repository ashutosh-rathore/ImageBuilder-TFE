#Create IAM role first
#Create pipeline then

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