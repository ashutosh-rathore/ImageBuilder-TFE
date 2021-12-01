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


/* this is still on testing to directly create AMI
resource "aws_imagebuilder_image" "NewImage-TFE" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.NewRecipe2-TFE.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.NewConfig2-TFE.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.NewDistSet2-TFE.arn


  depends_on = [
    aws_imagebuilder_image_recipe.NewRecipe2-TFE,
    aws_imagebuilder_distribution_configuration.NewDistSet2-TFE,
    aws_imagebuilder_infrastructure_configuration.NewConfig2-TFE
  ]
}*/


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

/*
resource "aws_s3_bucket_object" "compofile" {
  for_each = fileset("/arimagebuildcomponents/", "*")

  bucket = var.aws_s3_bucket
  key    = "/arimagebuildcomponents/${each.value}"
  source = "/arimagebuildcomponents/${each.value}"
  # If the md5 hash is different it will re-upload
  etag = filemd5("/arimagebuildcomponents/${each.value}")
}
data "aws_s3_bucket_object" "compfile" {

}
data "aws_kms_key" "image_builder" {
  key_id = "alias/image-builder"
}
*/